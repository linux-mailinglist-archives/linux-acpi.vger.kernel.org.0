Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BC91C4611
	for <lists+linux-acpi@lfdr.de>; Mon,  4 May 2020 20:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgEDSh1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 May 2020 14:37:27 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:6174 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725981AbgEDSh1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 May 2020 14:37:27 -0400
X-Greylist: delayed 10771 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 May 2020 14:37:27 EDT
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 044FVLif032765;
        Mon, 4 May 2020 11:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=qKQjYVmtNTVgpbpac2gqElMiV14sV7QCUi4AU9A9xJo=;
 b=Ffwvw4KOWUQzKXiWWP0056LuzyE4Me+2yUY5XgAhf0vXZbfxsgeaSY0jY/ufipHDxErl
 VLQZQfgcMttzZq9VO2bVHdsSqtQ7arYubUsAp8CX/8b9/EsIhsHpcki7U8NBDcLfAkEW
 SqCiL2p19EmCcvdusbYp4wxokLeiZELS00HdzblfDN0rd5zNSjiFcPZkwzDnt7BzvOIT
 irOXmFjSd3uheocPw8k4KFZZYfW0gIG2cHha9UC+wsTd/V/U/3yoPmx5BtcHZaUPY14C
 BqyVtMYg8Dyn+GgPBkYDibi/Rs2tx+08XkxzcmZAoeGGIVN9Zav8n8PQakRr38scKYxq ZQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 30sxjm2eks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 May 2020 11:37:54 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 044FWhDC053426;
        Mon, 4 May 2020 11:37:54 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0b-00154901.pphosted.com with ESMTP id 30s57eg0g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 11:37:54 -0400
X-LoopCount0: from 10.166.132.128
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,346,1549951200"; 
   d="scan'208";a="1384301358"
From:   <Mario.Limonciello@dell.com>
To:     <hdegoede@redhat.com>, <dvhart@infradead.org>, <andy@infradead.org>
CC:     <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/5] platform/x86: intel-vbtn: Also handle tablet-mode
 switch on "Detachable" and "Portable" chassis-types
Thread-Topic: [PATCH 4/5] platform/x86: intel-vbtn: Also handle tablet-mode
 switch on "Detachable" and "Portable" chassis-types
Thread-Index: AQHWIK+7lmbxrem4aUOvjmuguWcpP6iYECVg
Date:   Mon, 4 May 2020 15:37:51 +0000
Message-ID: <7c3e5f844a224ff780cd8e3b3f5f7641@AUSX13MPC101.AMER.DELL.COM>
References: <20200502182951.114231-1-hdegoede@redhat.com>
 <20200502182951.114231-5-hdegoede@redhat.com>
In-Reply-To: <20200502182951.114231-5-hdegoede@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-05-04T15:37:48.8278993Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=5e6660b9-a2eb-46dd-82e8-74aa2b3a23f5;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.60]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-04_10:2020-05-04,2020-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 phishscore=0 clxscore=1011 mlxlogscore=999 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040126
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 malwarescore=0 adultscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040126
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Hans de Goede <hdegoede@redhat.com>
> Sent: Saturday, May 2, 2020 1:30 PM
> To: Darren Hart; Andy Shevchenko; Limonciello, Mario
> Cc: Hans de Goede; linux-acpi@vger.kernel.org; platform-driver-
> x86@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 4/5] platform/x86: intel-vbtn: Also handle tablet-mode sw=
itch
> on "Detachable" and "Portable" chassis-types
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> Commit de9647efeaa9 ("platform/x86: intel-vbtn: Only activate tablet mode
> switch on 2-in-1's") added a DMI chassis-type check to avoid accidentally
> reporting SW_TABLET_MODE =3D 1 to userspace on laptops.
>=20
> Some devices with a detachable keyboard and using the intel-vbnt (INT33D6=
)
> interface to report if they are in tablet mode (keyboard detached) or not=
,
> report 32 / "Detachable" as chassis-type, e.g. the HP Pavilion X2 series.
>=20
> Other devices with a detachable keyboard and using the intel-vbnt (INT33D=
6)
> interface to report SW_TABLET_MODE, report 8 / "Portable" as chassis-type=
.
> The Dell Venue 11 Pro 7130 is an example of this.
>=20
> Extend the DMI chassis-type check to also accept Portables and Detachable=
s
> so that the intel-vbtn driver will report SW_TABLET_MODE on these devices=
.
>=20
> Note the chassis-type check was originally added to avoid a false-positiv=
e
> tablet-mode report on the Dell XPS 9360 laptop. To the best of my knowled=
ge
> that laptop is using a chassis-type of 9 / "Laptop", so after this commit
> we still ignore the tablet-switch for that chassis-type.

Yes that's correct.

>=20
> Fixes: de9647efeaa9 ("platform/x86: intel-vbtn: Only activate tablet mode
> switch on 2-in-1's")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Looking at the Microsoft Windows documentation for tablet-mode reporting:
> https://docs.microsoft.com/en-us/windows-hardware/drivers/gpiobtn/button-
> implementation
>=20
> Then the presence of a tablet-mode switch is indicated by the presence
> of a PNP0C60 compatible ACPI devices. There are 2 ways in which this devi=
ce
> can report the tablet-mode. 1. Directly providing a GpioInt resource insi=
de
> the PNP0C60 device, 2. Through injecting events from a Windows driver.
>=20
> It seems that the intel-vbtn / the INT33D6 ACPI device is the ACPI side
> of Intel's generic solution for the case where the tablet-mode comes from
> the embedded-controller and needs to be "injected".
>=20
> This all suggests that it might be better to replace the chassis-type
> check with a acpi_dev_present("PNP0C60", NULL, -1) check.
>=20
> Mario, can you provide an acpidump and alsa-info.sh output for the
> Dell XPS 9360, so that I can check if that might help with the issue
> there, and thus is a potential candidate to replace the chassis-type
> check?

Unfortunately with WFH right now, I don't have access to a XPS 9630 to
double check the patch series.

However I do agree this should be a good approach.

Reviewed-by: Mario Limonciello <Mario.limonciello@dell.com>

> ---
>  drivers/platform/x86/intel-vbtn.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/int=
el-
> vbtn.c
> index 500fae82e12c..4921fc15dc6c 100644
> --- a/drivers/platform/x86/intel-vbtn.c
> +++ b/drivers/platform/x86/intel-vbtn.c
> @@ -158,12 +158,22 @@ static void detect_tablet_mode(struct platform_devi=
ce
> *device)
>  static bool intel_vbtn_has_switches(acpi_handle handle)
>  {
>  	const char *chassis_type =3D dmi_get_system_info(DMI_CHASSIS_TYPE);
> +	unsigned long chassis_type_int;
>  	unsigned long long vgbs;
>  	acpi_status status;
>=20
> -	if (!(chassis_type && strcmp(chassis_type, "31") =3D=3D 0))
> +	if (kstrtoul(chassis_type, 10, &chassis_type_int))
>  		return false;
>=20
> +	switch (chassis_type_int) {
> +	case  8: /* Portable */
> +	case 31: /* Convertible */
> +	case 32: /* Detachable */
> +		break;
> +	default:
> +		return false;
> +	}
> +
>  	status =3D acpi_evaluate_integer(handle, "VGBS", NULL, &vgbs);
>  	return ACPI_SUCCESS(status);
>  }
> --
> 2.26.0

