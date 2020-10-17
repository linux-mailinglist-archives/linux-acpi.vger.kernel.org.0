Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB0029102C
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Oct 2020 08:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437043AbgJQGaO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 17 Oct 2020 02:30:14 -0400
Received: from sonic308-19.consmr.mail.ir2.yahoo.com ([77.238.178.147]:38149
        "EHLO sonic308-19.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436965AbgJQGaO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 17 Oct 2020 02:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1602916212; bh=815eJ56VHnklTDk+DCOG4XAfdC9czamW+ZJP9hVvUQw=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Qh0cir5ZMlSYJGegr0QUGJ7Gk9PA2rxTGk2HKXFQuXq0N0QY0A4BZxTi8reottcOtj3x8iwJQcpgHoKLZggm1jSLqBWP9MHrP7YmRSh4cbYdfUns3zE6JfoGc3b8b30RtXDIN12pyFI4kJPzScl7cQ/BPn5ITUl24AZVhdjQAZoKynf2FdmPjcQKn+YZN9IT1sFFb88cP65Y2HMK+ar2bW6DV9p3TZDkZa3tDeYlscSKXo4t7BPEm9hfZpfeFSmCZdNe4k7vnQZha8rsbq1wZ7iJzgJ46pHQZS0Gh4SsVzI+EFTmrov4eDyk/3j4Q5g+6CspXCN75GFTIBafSDIRYA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1602916212; bh=NDlDg284a1ly9T+Q/08PWkP2JDT9lpe4Pz4h/iHwBOZ=; h=Date:From:Subject; b=sNogEz2bv/kKpT6bhhRq5oe35j8+QPf5geXzCSos+N8H+O5QmXQa6Hmf+OvujLNVnr8PglruRNNfkDPZKBeiCvWibrZz/MJ6i3WfK3NRP1rDhON/mONTxKPPU8HWva095GNIzW7y2rsnZAb566OAbHVqP/g4joVwZOQhhDfDXWlac9HRGKU0txybRRDS5u/fd0Zk73GLuTqHQRPkC1zDa4cqrO5/CVK6ofJWSpkoPNmNft1s5uFXdB4FyuGavf25+Qv3GEoVnyrfR/lC3d545CKIPjsXT7veEwCC0XYtLj4eDpFsjPNvU21tFv8We0Owg5VLMpiUscFnB6G181bDRA==
X-YMail-OSG: ZPB8wkQVM1lORKGeiBXn74FpiZ6lu_tsfwnoLIWY_Af3ynmW8WgPBsCQIumCw2H
 fdsa5g7K_AxxLRtpd6r9CPsCehxI7O5Qi6rVPOSsh.DkFCJ34vUHD0.NM5jaE9ySrbRJwzqdv.Qd
 lP6lEU_BADkZF2uo5hnPpALWoMQfsLK0eZjl8n5J2KOM36AUqXRm3LJ_bweBA_osrSzGULWpX3KE
 oNq7cMclJ.drzhXycbnZ7lRysw6RjNm8L7YSWnJDlxnX1GuL8a934IPsRylsffHe7GdmGeMB0wuk
 zGQJAq3Esi4boFVewQJgmLRXdteWdCAcUiYUKeW6peBeWk1.aAl.3RqlTNRje4ej.Ivgqs..rSro
 .M5ZQkmzlmk62VCgpRcONQJMWQlCsJbBG6PiGnOfoGQOrlNeTr7FlvPoxT9Nei14yq3lkX.05vno
 8lR9SdRB4V5ewelwqHDUxXYHwJ4qVAdZrnaz3_4Pwce4XORjweE4Lm24koGe_4aQk51nJPWwdBNf
 83vbC9LDnADlcwiEmubR3gp5ZzIAU0aG6GVOHGhypu4MMBEo0is13Zbfdk8GbBBzvwCqADKZuPf5
 w7s2xJYy5aWxtyQv5Qjy36.zHtlNAJT4V3_WZZJn4xmt8Alipfs3X.DbS_7P3mrTaqBksN7szvCs
 370npbr1kju_zwyQTv3Cd03P7uJK97inBXkivRO.hDt0g_b28omxRapzdW_M0LqL5pZd_F.xVAbD
 ZfmmPN.J8.io1rmtX35rtVks5V5oGlwMmQTaaPDHK8l6jwxcOOz_qLhHMP9WJZcw6bO4NCclje_K
 Ebc82JAH0i3HhS9SXIsGicLGo9iXgO0e8kC6cAq._Cgz.4Lk7__K9MQF_M4WVNR_6QVOZt.nML2r
 fcht1yGZtTx_7ETJIaQ3gcJKwn8UY7G_NZFNK80Q7lMUrCaT.svyrCQPmPay0fyUVTSTFxWyZuCm
 xCXwdV3O1l0NYatrOK5a5IdFqLon1ZfC5F0MAvIToEt9Oivt2EtRlSQdoz2W_8LFMtfVR5WmzYxF
 otnV6jwaNnfbZzwhAj9YLmOTPtO.ZY7YsSbHqiYvAWd_dgFyHx4KbQL1O76hIhcctXQAd_d56Jc2
 nCsf6z9F.BS8ieQakLrrKCAlztN5xznbBTPFeCKThRicxgiT4looUKxWWtMUCVG4hDNuL7dXtdLh
 ufKxEqbduxau6Ij7aoJ3T3DIRVamENBV0iP8UKS186ttTqjaRFR8c8GAOO2EEt2n3SM7AD6oY4S8
 6pRpGMce0B6BxO6wuThA772MbxCYbx9nC_j4P7TMqLW5X3gTkeiqdOkvPyXw0zfLD2yzWfrTWc3y
 PVcCz39923wv02YQGSQnq3oxGVQflmB2ammhFrudz0xtQ3Rrba8lZ5dqOtXjmmPwsgiaxhZ0hdaf
 aUkgNSKkgpkB9PoZXcGdIQ5B5PpesivKMrKhVVKIhNA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Sat, 17 Oct 2020 06:30:12 +0000
Date:   Sat, 17 Oct 2020 06:30:11 +0000 (UTC)
From:   "Mrs. Barbara Roth." <mrsemailcontact1@aol.com>
Reply-To: mrsemailcontact1@aol.com
Message-ID: <1555328078.607655.1602916211821@mail.yahoo.com>
Subject: Dearest beloved in the Lord,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1555328078.607655.1602916211821.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16868 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org





Dearest beloved in the Lord,

Mine names are Mrs. Barbara Roth, I am a 66 years old woman. My beloved lat=
e husband is from United Kingdom England, while I am of a Dutch nationality=
 by birth .I was born an orphan and GOD blessed me and mine late beloved hu=
sband with abundantly with riches but no children. I am not a happy woman b=
ecause i have no husband or children, my husband died 21 years ago. Right n=
ow I am affected with cancer of the lung and breast i also have partial str=
oke which has affected my speeches. I can no longer talk well and half of m=
y body is paralyzed, i send this email to you with the help of my private f=
emale nurse who is typing my request at China cancer research facility.

My condition is really deteriorating and is quite obvious that i may not li=
ve more than 3 weeks, because the cancer stage has gotten to its 3rd stage.=
 After my Doctor Notice, i have decided to divide part of my fortune by con=
tributing to the Charities & Motherless. I don't know you but i am contacti=
ng you with the hope that, you will be able to carry out my wish for the sa=
ke of humanity.

I am willing to donate the sum of =EF=BF=A110,500,000.00, Ten Million Five =
Hundred Thousand, Great Britain Pound to the poor through you. I have also =
made some cash donations to orphanage children in Somalia, Syria, Ethiopian=
, Cambodia, Philippines, South Sudan and some in South Africa and Europe.

If you are willing and able to do this task for the sake of humanity then s=
end me below information for more details to receive the funds.
1. Name...................................................
2. Phone number...............................
3. Address.............................................
May GOD guide you.

Mrs. Barbara Roth.
