using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Security.Cryptography;
using System.Text;
using System.Data;
using System.Data.SqlClient;


namespace Password_Hashing
{
    public partial class Registration : System.Web.UI.Page
    {

        string MYDBConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MYDBConnection"].ConnectionString;
        static string finalHash;
        static string salt;
        byte[] Key;
        byte[] IV;
        byte[] CCKey;
        byte[] CCIV;
        

        static string line = "\r";

        //static string isDebug = ConfigurationManager.AppSettings["isDebug"].ToString();


        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_Submit_Click(object sender, EventArgs e)
        {
            string pwd = HttpUtility.HtmlEncode(tb_pwd.Text.ToString().Trim());

            //Generate random "salt" 
            RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
            byte[] saltByte = new byte[8];

            //Fills array of bytes with a cryptographically strong sequence of random values.
            rng.GetBytes(saltByte);
            salt = Convert.ToBase64String(saltByte);

            SHA512Managed hashing = new SHA512Managed();

            string pwdWithSalt = pwd + salt;
            byte[] plainHash = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwd));
            byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwdWithSalt));

            finalHash = Convert.ToBase64String(hashWithSalt);

            lb_error1.Text = "Salt:" + salt;
            lb_error2.Text = "Hash with salt:" + finalHash;

            RijndaelManaged cipher = new RijndaelManaged();
            cipher.GenerateKey();
            Key = cipher.Key;
            IV = cipher.IV;

            RijndaelManaged cardcipher = new RijndaelManaged();
            cardcipher.GenerateKey();
            CCKey = cipher.Key;
            CCIV = cipher.IV;


            createAccount();
            Response.Redirect(HttpUtility.UrlEncode("Login.aspx"));
        }


        protected void createAccount()
        {


            using (SqlConnection con = new SqlConnection(MYDBConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("INSERT INTO Account VALUES(@Email,@FirstName,@PasswordHash,@PasswordSalt,@EmailVerified,@LastName,@CreditCardNo,@CCIV,@CCKey,@DOB)"))
                //using (SqlCommand cmd = new SqlCommand("INSERT INTO Account VALUES(@Email, @Mobile,@Nric,@PasswordHash,@PasswordSalt,@DateTimeRegistered,@MobileVerified,@EmailVerified)"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.Parameters.AddWithValue("@FirstName", tb_firstname.Text.Trim());
                        cmd.Parameters.AddWithValue("@LastName", tb_lastname.Text.Trim());
                        cmd.Parameters.AddWithValue("@CreditCardNo", Convert.ToBase64String(encryptData(tb_creditcardno.Text.Trim())));
                        cmd.Parameters.AddWithValue("@Email", tb_email.Text.Trim());
                        cmd.Parameters.AddWithValue("@PasswordHash", finalHash);
                        cmd.Parameters.AddWithValue("@PasswordSalt", salt);
                        cmd.Parameters.AddWithValue("@EmailVerified", DBNull.Value);
                        cmd.Parameters.AddWithValue("@CCIV", Convert.ToBase64String(IV));
                        cmd.Parameters.AddWithValue("@CCKey", Convert.ToBase64String(Key));
                        cmd.Parameters.AddWithValue("@DOB", tb_dob.Text.Trim());
                        cmd.Connection = con;
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();

                        try
                        {
                            con.Open();
                            cmd.ExecuteNonQuery();
                            //con.Close();
                        }
                        catch (Exception ex)
                        {
                            //throw new Exception(ex.ToString());
                            lb_error1.Text = ex.ToString();
                        }
                        finally
                        {
                            con.Close();
                        }
                    }
                }
            }


        }

        protected byte[] encryptData(string data)
        {
           
            byte[] cardcipherText = null;
            try
            {
                RijndaelManaged cardcipher = new RijndaelManaged();
                cardcipher.IV = CCIV;
                cardcipher.Key = CCKey;
                
               
                ICryptoTransform cardencryptTransform = cardcipher.CreateEncryptor();
                //ICryptoTransform decryptTransform = cipher.CreateDecryptor();
                byte[] plainText = Encoding.UTF8.GetBytes(data);
                byte[] Text = Encoding.UTF8.GetBytes(data);
                cardcipherText = cardencryptTransform.TransformFinalBlock(Text, 0, Text.Length);


                //Encrypt
                //cipherText = encryptTransform.TransformFinalBlock(plainText, 0, plainText.Length);
                //cipherString = Convert.ToBase64String(cipherText);
                //Console.WriteLine("Encrypted Text: " + cipherString);

            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }

            finally { }
            return cardcipherText;
        }
    }
}