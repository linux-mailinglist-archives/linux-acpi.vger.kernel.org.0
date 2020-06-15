Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F9A1F9D32
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jun 2020 18:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbgFOQXC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Jun 2020 12:23:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35558 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729949AbgFOQXB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jun 2020 12:23:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05FGMdFX038242;
        Mon, 15 Jun 2020 16:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : message-id :
 content-type : mime-version : subject : date : in-reply-to : cc : to :
 references; s=corp-2020-01-29;
 bh=9LPSGGeBHXZlI3mrDl11xSAyahEZRFnjRlfXvOp90rc=;
 b=GWDefzidqVC2brxh0WZ3BGv+lh9SaJibEB6XXXxy2sL7OaZ40fA/VnAXniUJaDb2gaM0
 Xwj7QVdaun1tZYVMybjnzyekweavZr8nAXjscgFvk7s2NiIZvOMF/UB/iMqnDsgdwbeA
 RuzTwdBqjHlq73celgtaC97LyUFdnTlecx10KisqhUI8UiHAo8yren4tbhN5bTJbyh17
 Xke5C46mrV6hox4mDesf8ltppp5BYCARQRJKSmszeUOQuXp6+jckSvIngOFxptwDq8BT
 Rfu9rSdNlqzlyJ5kATvbU4eNnlSskbxM5uX/JTmo6dR8exoG8byklEZDlteCk6YESe7J xA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 31p6s21w3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Jun 2020 16:22:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05FGDJ4I149951;
        Mon, 15 Jun 2020 16:22:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 31p6db805w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jun 2020 16:22:39 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05FGMTbH013709;
        Mon, 15 Jun 2020 16:22:30 GMT
Received: from [10.175.200.36] (/10.175.200.36)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Jun 2020 09:22:29 -0700
From:   John Haxby <john.haxby@oracle.com>
Message-Id: <206DB19C-0117-4F4B-AFF7-212E40CB8C75@oracle.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_79F4D81D-D509-4941-8339-0DAC46A53B1C";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [oss-security] lockdown bypass on mainline kernel for loading
 unsigned modules
Date:   Mon, 15 Jun 2020 17:22:27 +0100
In-Reply-To: <CAHmME9rmAznrAmEQTOaLeMM82iMFTfCNfpxDGXw4CJjuVEF_gQ@mail.gmail.com>
Cc:     linux-security-module@vger.kernel.org, linux-acpi@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        kernel-hardening@lists.openwall.com,
        Ubuntu Kernel Team <kernel-team@lists.ubuntu.com>
To:     oss-security@lists.openwall.com,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <CAHmME9rmAznrAmEQTOaLeMM82iMFTfCNfpxDGXw4CJjuVEF_gQ@mail.gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9653 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006150126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9653 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 clxscore=1034 mlxscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 cotscore=-2147483648 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006150127
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--Apple-Mail=_79F4D81D-D509-4941-8339-0DAC46A53B1C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Jason,


> On 15 Jun 2020, at 11:26, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>=20
> Hi everyone,
>=20
> Yesterday, I found a lockdown bypass in Ubuntu 18.04's kernel using
> ACPI table tricks via the efi ssdt variable [1]. Today I found another
> one that's a bit easier to exploit and appears to be unpatched on
> mainline, using acpi_configfs to inject an ACPI table. The tricks are
> basically the same as the first one, but this one appears to be
> unpatched, at least on my test machine. Explanation is in the header
> of the PoC:
>=20
> =
https://git.zx2c4.com/american-unsigned-language/tree/american-unsigned-la=
nguage-2.sh
>=20
> I need to get some sleep, but if nobody posts a patch in the
> meanwhile, I'll try to post a fix tomorrow.
>=20
> Jason
>=20
> [1] https://www.openwall.com/lists/oss-security/2020/06/14/1


This looks CVE-worthy.   Are you going to ask for a CVE for it?

jch

--Apple-Mail=_79F4D81D-D509-4941-8339-0DAC46A53B1C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iHUEAREIAB0WIQT+pxvb11CFWUkNSOVFC7t+lC+jyAUCXuegQwAKCRBFC7t+lC+j
yItsAQCs9qh0q24Rr/pL5VTN/Nt6fJj38GzSCQNVyCcBs8X55gD+OdD6c88Q91b/
tFCKvrk8joQsG5RiFiqNQpod8AORs+s=
=x0MT
-----END PGP SIGNATURE-----

--Apple-Mail=_79F4D81D-D509-4941-8339-0DAC46A53B1C--
