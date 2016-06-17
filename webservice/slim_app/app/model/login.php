<?php
namespace App\Model;

use App\Lib\Database;
use App\Lib\Response;

class LoginModel
{
    private $db;
    private $table = 'login';
    private $response;
    
    public function __CONSTRUCT()
    {
        $this->db = Database::StartUp();
        $this->response = new Response();
    }
    
    public function GetAll()
    {
		try
		{
			$result = array();

			$stm = $this->db->prepare("SELECT * FROM $this->table");
			$stm->execute();
            
			$this->response->setResponse(true);
            $this->response->result = $stm->fetchAll();
            
            return $this->response;
		}
		catch(Exception $e)
		{
			$this->response->setResponse(false, $e->getMessage());
            return $this->response;
		}
    }
    
    public function Get($id)
    {
		try
		{
			$result = array();

			$stm = $this->db->prepare("SELECT * FROM $this->table WHERE id = ?");
			$stm->execute(array($id));

			$this->response->setResponse(true);
            $this->response->result = $stm->fetch();
            
            return $this->response;
		}
		catch(Exception $e)
		{
			$this->response->setResponse(false, $e->getMessage());
            return $this->response;
		}  
    }

    public function GetValLogin($login,$pass)
    {
        try
        {
            $result = array();
            $data[] = array('login' => 'daniel2864@gmail.com','pass'=>'12345' );

            $stm = $this->db->prepare("SELECT * FROM $this->table WHERE login = ? AND passw = ?");
            $stm->execute(array($login,$pass));

            $this->response->setResponse(true);
            $this->response->result = $stm->fetch();
            
            //return $data;
            return $this->response;
        }
        catch(Exception $e)
        {
            $this->response->setResponse(false, $e->getMessage());
            return $this->response;
        }  
    }
    
    public function InsertOrUpdate($data)
    {
		try 
		{
            if(isset($data['id']))
            {
                $sql = "UPDATE $this->table SET 
                            login          = ?, 
                            passw          = ?
                        WHERE id = ?";
                
                $this->db->prepare($sql)
                     ->execute(
                        array(
                            $data['login'], 
                            $data['passw'],
                            $data['id']
                        )
                    );
            }
            else
            {
                $sql = "INSERT INTO $this->table
                            (login, passw)
                            VALUES (?,?)";
                
                $this->db->prepare($sql)
                     ->execute(
                        array(
                            $data['login'], 
                            $data['passw']
                        )
                    ); 
            }
            
			$this->response->setResponse(true);
            return $this->response;
		}catch (Exception $e) 
		{
            $this->response->setResponse(false, $e->getMessage());
		}
    }
    
    public function Delete($id)
    {
		try 
		{
			$stm = $this->db
			            ->prepare("DELETE FROM $this->table WHERE id = ?");			          

			$stm->execute(array($id));
            
			$this->response->setResponse(true);
            return $this->response;
		} catch (Exception $e) 
		{
			$this->response->setResponse(false, $e->getMessage());
		}
    }
}