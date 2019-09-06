Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3656AC1C0
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Sep 2019 23:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfIFVAm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Sep 2019 17:00:42 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:3190 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbfIFVAm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Sep 2019 17:00:42 -0400
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x86KxgDF008666;
        Fri, 6 Sep 2019 17:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dellteam.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=z/wuUxYwWGUvcFR+u6a/mG0Roowqz6Ua+5JEJbN/d0c=;
 b=ZGbjb0g9SkoY8fb8MrezRDrW9FHewuPuv3M7iVWIysB4Hkf0Es3I563nOnHuMAzjYBEv
 sdDIBnL/L5TttSgAIjQLzP8uRlnNkVfMKHff3tdVWwWXU4YOcb8UyTxxw7gTlBW0VTnw
 WQTpRb5TMrgu7kpjAAgVjvQ9/ABKV1sD7CpK1acF0wAxFyF5Ou42+Smp61rH3MXPYlgt
 R1h5SutJAt/CjoGzAitNssdEPDrKM3l0KQ47oH/Kkoo7idowgHOeUucDT/8FZG+tDRWG
 a9JJQEkfM1LyogicfW0rMI3De1cBevm1zxwTnthIMkNR6Z1qnb4LmAV/EYPFLS1yJfHO AQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2uqm7jv942-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Sep 2019 17:00:41 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x86KwZvu141196;
        Fri, 6 Sep 2019 17:00:40 -0400
Received: from ausc60pc101.us.dell.com (ausc60pc101.us.dell.com [143.166.85.206])
        by mx0a-00154901.pphosted.com with ESMTP id 2uu3x2b24c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Sep 2019 17:00:40 -0400
X-LoopCount0: from 10.166.132.134
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1462907422"
From:   <Charles.Hyde@dellteam.com>
To:     <bjorn@mork.no>
CC:     <stern@rowland.harvard.edu>, <oliver@neukum.org>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <Mario.Limonciello@dell.com>, <chip.programmer@gmail.com>,
        <nic_swsd@realtek.com>, <linux-usb@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH 1/3] net: cdc_ncm: add get/set ethernet address functions
Thread-Topic: [PATCH 1/3] net: cdc_ncm: add get/set ethernet address functions
Thread-Index: AQHVZPM2VbpOtOy+DEKwLQ92ABp4yKcfIR3A
Date:   Fri, 6 Sep 2019 21:00:38 +0000
Message-ID: <83c59bc63a8042d5afa622bda542864f@AUSX13MPS307.AMER.DELL.COM>
References: <43fa8b0a974d426faccf5e6d486af18a@AUSX13MPS307.AMER.DELL.COM>
        <Pine.LNX.4.44L0.1909061412350.1627-100000@iolanthe.rowland.org>
        <a9999ed336ba4f2a8cb93c57f0b3d2f4@AUSX13MPS307.AMER.DELL.COM>
        <87mufhqjdb.fsf@miraculix.mork.no>
        <d8cdacc63ddd4da4a88d3712b2b53d32@AUSX13MPS307.AMER.DELL.COM>
 <87ftl9qhv4.fsf@miraculix.mork.no>
In-Reply-To: <87ftl9qhv4.fsf@miraculix.mork.no>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Charles_Hyde@Dellteam.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-09-06T21:00:37.5781424Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-06_09:2019-09-04,2019-09-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=870
 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909060214
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 spamscore=0 impostorscore=0 bulkscore=0 mlxlogscore=968 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909060214
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

<snipped>=20
> static int cdc_ncm_init(struct usbnet *dev) {
> 	struct cdc_ncm_ctx *ctx =3D (struct cdc_ncm_ctx *)dev->data[0];
> 	u8 iface_no =3D ctx->control->cur_altsetting->desc.bInterfaceNumber;
> 	int err;
>=20
> 	err =3D usbnet_read_cmd(dev, USB_CDC_GET_NTB_PARAMETERS,
> 			      USB_TYPE_CLASS | USB_DIR_IN
> 			      |USB_RECIP_INTERFACE,
> 			      0, iface_no, &ctx->ncm_parm,
> 			      sizeof(ctx->ncm_parm));
> ,,
>=20
> You'll obviously have to replace USB_CDC_GET_NTB_PARAMETERS with
> USB_CDC_GET_NET_ADDRESS, &ctx->ncm_parm with buf, and
> sizeof(ctx->ncm_parm) with ETH_ALEN.
>=20
>=20
> Bj=F8rn

Not everything is obvious to those who do not live and breathe USB.  This h=
as been an experience.

Is this snippet what you have in mind?  Will iface_no be correct?  If not, =
then what do you suggest?

/* Provide method to push MAC address to the USB device's ethernet controll=
er.
 * If the device does not support CDC_SET_ADDRESS, there is no harm and we
 * proceed as before.
 */
static int cdc_ncm_set_ethernet_address(struct usbnet *dev,
					struct sockaddr *addr)
{
	int ret;
	struct cdc_ncm_ctx *ctx =3D (struct cdc_ncm_ctx *)dev->data[0];
	u8 iface_no =3D ctx->control->cur_altsetting->desc.bInterfaceNumber;

	ret =3D usbnet_write_cmd(dev, USB_CDC_SET_NET_ADDRESS,
			       USB_DIR_OUT | USB_TYPE_CLASS
			       | USB_RECIP_INTERFACE, 0, iface_no,
			       addr->sa_data, ETH_ALEN);
	if (ret =3D=3D ETH_ALEN)
		ret =3D 0;	/* success */
	else if (ret < 0)
		dev_dbg(&dev->udev->dev, "bad MAC address put, %d\n", ret);

	return ret;
}
