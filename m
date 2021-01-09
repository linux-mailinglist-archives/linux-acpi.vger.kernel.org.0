Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB292EFE99
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Jan 2021 09:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbhAIIZ5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 9 Jan 2021 03:25:57 -0500
Received: from mail-eopbgr700103.outbound.protection.outlook.com ([40.107.70.103]:14305
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725847AbhAIIZ4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 9 Jan 2021 03:25:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0D4IurOtVPFjr0zANzHl+SLJ4klquMUccPLpOddHuyyt5U2OtsQhcouihvYJSENIejmbISssPKUCXgjksXliQxSFTvDwIjIlhq05ZogVdK4bQdp0Z+6FVEqDVYGBgZL9NTnMzrYgON4XfoJD6EDCfaNFGQX+qrZr0NWEBYhmV9usoCNjtmoyLf0UQ+pABrWTN6EbeE7IDkpA1yoT7FcKRU3ACLeRfutwO+2UpMt9Ttd3hbpC2CRATUXBIXUR20bUD/ntxARzxDpI+CmFNPl3YecwlYRR7zzNK0pzrDfPO+Bi/QnRlwCcGG2MMZeTdGmEeZ41SACf10xW7GK1i0+5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bic6jT7GKvsokUTXL27rb+odWB3oGUsojVYPJ0w9V3A=;
 b=VE49YV3PUAqA/Aj7Vygk7rA4PTlzK+zbuW3sEhpynD+KuHY9yNXSAQ536xwhumaTLchbLBERXW6BJa3Hp89B14aVW75tJzAMYYC3wiTp1QGUKLyLXb4fWv3FdwUTXAflQn/GVyqizlDzVjWul6+UZx3EW3Yf9895VAm5x9izVFLfr7qnO7Ctl6uX+JMsVQI+zJtSRdYS6Su3EaW73aWWDg/dF9hzlmbfb1GxidAz7waqhbJRloa1pWhfsZC91vuiHsz2bsZ+ScV18Oo7MyHnGE3fQQbmyivnRSkYS/lLnWU0/Mvlc4af1LD5NG5Y+F61idjM3hfoR8rg8EAjyHuQPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fortanix.com; dmarc=pass action=none header.from=fortanix.com;
 dkim=pass header.d=fortanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fortanix.onmicrosoft.com; s=selector2-fortanix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bic6jT7GKvsokUTXL27rb+odWB3oGUsojVYPJ0w9V3A=;
 b=pkol6HHVT0dZRPOJ/aD7MTkMrJhWKtRovJEY45i40ZQKCA9UbQfAQrf7uT2Yg2p2rCTl+Vw5dDw9+ZseLndHVn5P5abgwFvEARnJCU3oxoYFAKQLk40W01wcPPqEAhkavchbT951KMO61FVAArE4dxCoNq4hlPw0ayIWSsQTljQ=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fortanix.com;
Received: from BY5PR11MB4260.namprd11.prod.outlook.com (2603:10b6:a03:1ba::30)
 by BY5PR11MB4243.namprd11.prod.outlook.com (2603:10b6:a03:1c8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Sat, 9 Jan
 2021 08:25:06 +0000
Received: from BY5PR11MB4260.namprd11.prod.outlook.com
 ([fe80::84e0:4df6:7a70:eee5]) by BY5PR11MB4260.namprd11.prod.outlook.com
 ([fe80::84e0:4df6:7a70:eee5%6]) with mapi id 15.20.3742.009; Sat, 9 Jan 2021
 08:25:06 +0000
Subject: Re: [PATCH v2] ACPI: scan: Fix a Hyper-V Linux VM panic caused by
 buffer overflow
To:     decui@microsoft.com, rafael@kernel.org, linux-acpi@vger.kernel.org,
        rjw@rjwysocki.net, len.brown@intel.com, mikelley@microsoft.com
Cc:     linux-kernel@vger.kernel.org, wei.liu@kernel.org,
        sthemmin@microsoft.com, haiyangz@microsoft.com, kys@microsoft.com,
        dwaipayanray1@gmail.com, Steve French <smfrench@gmail.com>
References: <20210108072348.34091-1-decui@microsoft.com>
From:   Jethro Beekman <jethro@fortanix.com>
Message-ID: <6b007d26-73e8-f85f-cf74-1accf3e13fea@fortanix.com>
Date:   Sat, 9 Jan 2021 09:24:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210108072348.34091-1-decui@microsoft.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms060601090805080101070809"
X-Originating-IP: [213.127.127.169]
X-ClientProxiedBy: AM3PR07CA0115.eurprd07.prod.outlook.com
 (2603:10a6:207:7::25) To BY5PR11MB4260.namprd11.prod.outlook.com
 (2603:10b6:a03:1ba::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.4.219] (213.127.127.169) by AM3PR07CA0115.eurprd07.prod.outlook.com (2603:10a6:207:7::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.4 via Frontend Transport; Sat, 9 Jan 2021 08:25:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77b26679-1eae-4ff4-a905-08d8b47811e5
X-MS-TrafficTypeDiagnostic: BY5PR11MB4243:
X-Microsoft-Antispam-PRVS: <BY5PR11MB4243CBFDAEC52F7EF5732FA3AAAD0@BY5PR11MB4243.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OaBHZ/wLpW3Jx153xoy0u3C5oXrCoqrd67djCBbLYt4HmVOtyMlCCDOB2vjplLZRqNbT1zMMG5jUCdY4OkiQyoBZaPLhzyC69AF2dJFJHEze1L/wwfl+IZbjLFrfsk4XVtEBiV0/RvGkbK72asG5blbadU1maZWa07Hpg1vPSKDW/Y9sZ07dmeUlRSygRXJhNmtU5O8hJum2EzDUxShc7mupVF6HVecQN7WrkXjTRHT/cjg5tAM7I2KfY3UQNeCd5wk5q9IywvVKpc2bLfKfbiv1240eFNECxX+tLsrdmIFL8sTNAO+MEjRNDo3Momz8vMb/jvemZh4aBKJtFTBYeEXDUrDSTbv9sIedBwpCuK4iSwSDy50PdPxVtgqSRGJoJwixlCbFudbTV8hxVNXtegsQLQgTMODU/aLefIQznN/+BnBrz0agl9l1pCGo7Iq2CMGHNQ6dVkJDqTGV+F5pdlUYiln3uK0+3QzFBKbF+LzrYKJjMFUtrGFKViFs0TLw09MWjcz55/KNonzMPp41oFK75G4DN374OtZqdlH0OMWVuClPmGMI8ZStY06kdwYU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4260.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(39840400004)(396003)(86362001)(52116002)(6486002)(8936002)(6666004)(31696002)(83380400001)(45080400002)(66476007)(7416002)(478600001)(31686004)(966005)(2906002)(16526019)(33964004)(316002)(956004)(53546011)(36756003)(2616005)(8676002)(5660300002)(66946007)(186003)(66556008)(16576012)(4326008)(26005)(235185007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UDdzNUw4L1pHWXp5SEF5dnl1b3N6bWY5d251ajl6UFl6WWhxRXg0SHFsYU9x?=
 =?utf-8?B?c3krYUJ3aGNVZlVTUUttWVFRK05vQnhaQzBKSGFzZ29UZGJyY2RIZ3ZxeVpO?=
 =?utf-8?B?NXpDbHJHKzh2WCs2Tmo5blVCUUM1V3pvdkxUMjMxRHpCR1dOWDF5Nm4veTBl?=
 =?utf-8?B?SlI2bU9LSlNEcFQwK2hsWDgyWHYzVldmcktOVGc4Vm5tVTBNUHFsMXpSNXdy?=
 =?utf-8?B?N1BYelcvOWhneWlPUlZ5emlZYVE2cVVQQUZadU9SSk1NUGZqRElDUm5XdXI1?=
 =?utf-8?B?WGM1QkZHR09FSHZKekRTTUo0ZzlkZ2NsckFrV1RQelF0akx5YTlZNGhBUDVM?=
 =?utf-8?B?OHp4MWs0ZC9rRkRod1NhOWJYdmdJMUVUQ2pHaXdVd0pWSkFqYzZGYzlCSzEz?=
 =?utf-8?B?cUtLMWdQbE16c2E3SVRVaXExRW8vM21LYlR2T21Hdi9LeXpNNEZNbTBiUVZa?=
 =?utf-8?B?ZHh3N29vbjhERklBMXdxQlMzR2M4RE5xS0lTQ0lJeFZMb2hXcnU0RFUwYXhh?=
 =?utf-8?B?b3loSVV1NnBsdEFRWUgvM3JPcHVla01QYUhoMlRUUnRWM1hCQUd6YUlCUXVS?=
 =?utf-8?B?WHNtVUdHZFdERkNjc3FJSmcyUVlPWmFML05MNDh3OExjdDdrU2hCcXc2aDQx?=
 =?utf-8?B?RGxGWWxDcUFwckFRdE9KVE85NUNvVGhhOVhaWldWemxhSndhQWFTcFRGVWVj?=
 =?utf-8?B?dlUrNFh1QlU5RS9aMmx5TlBQZTFMSEFlVE82STJWL3ZRYjJFU0N3bWw1NjlK?=
 =?utf-8?B?UFl0ZU1QcTVBSmk0SWsxZVhHdHczS2F5TjFZYlZGc3NQSHI0YjFwUmZ3cmJU?=
 =?utf-8?B?eUh5REtkZXk0aS9aWUVyb2p6YnUyV3pCdjFMRGNGMXRJQVZldGowNHZtbktB?=
 =?utf-8?B?Qk1Nd0dQa2ZhRG5Xd2o0QWdSalNYWm5MNnlhZXhUOTlHRlk2TjJXMFQvU21t?=
 =?utf-8?B?cVFBSHRwVGF1NkxuMUZxd2ppekZ3N1dJTnBMQm1hRlJxOXBnOEdUajdPbWdk?=
 =?utf-8?B?dzN1eVpQQUh4VElVYWVKKzFwWUEvcUN1WjkyRVJ1Yk9NdWt5V2dxekhrYVBP?=
 =?utf-8?B?WGNHdi9od2FVRjJOb1BUbzFSeCtyUjQvTk1KUWpDTGwrWmRvMWFYVEl4VzR2?=
 =?utf-8?B?LzIwNFpWUm9vbWVRbUhGMnRzMmFORC9wak5pc3QzbjduUmR3RmxENUQ3VEVM?=
 =?utf-8?B?amhGbnF5VGkyejFLS1k1VyszWHlOaGpwc0M5Mk9nT0ZsMUU4V0pQdXdGS0xl?=
 =?utf-8?B?QzZBeEdnU09nc003L2xtOUl2dXVVaVBKS3k1WVFBK2ZDQUtrMmlWZjJFVHJu?=
 =?utf-8?Q?0nLPZa0U3yfPjebsHYNcjhKzpRebraPLqu?=
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4260.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2021 08:25:05.9865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b26679-1eae-4ff4-a905-08d8b47811e5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SdxavG8jXcdMadnby0VldobtB8vpVNRLIVH2DJ6p/YJ8aPdeiMEeK98GfoIH7e7W3VZ24fdvGuvMvFfuEBLwww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4243
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

--------------ms060601090805080101070809
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2021-01-08 08:23, Dexuan Cui wrote:
> Linux VM on Hyper-V crashes with the latest mainline:
>=20
> [    4.069624] detected buffer overflow in strcpy
> [    4.077733] kernel BUG at lib/string.c:1149!
> ..
> [    4.085819] RIP: 0010:fortify_panic+0xf/0x11
> ...
> [    4.085819] Call Trace:
> [    4.085819]  acpi_device_add.cold.15+0xf2/0xfb
> [    4.085819]  acpi_add_single_object+0x2a6/0x690
> [    4.085819]  acpi_bus_check_add+0xc6/0x280
> [    4.085819]  acpi_ns_walk_namespace+0xda/0x1aa
> [    4.085819]  acpi_walk_namespace+0x9a/0xc2
> [    4.085819]  acpi_bus_scan+0x78/0x90
> [    4.085819]  acpi_scan_init+0xfa/0x248
> [    4.085819]  acpi_init+0x2c1/0x321
> [    4.085819]  do_one_initcall+0x44/0x1d0
> [    4.085819]  kernel_init_freeable+0x1ab/0x1f4
>=20
> This is because of the recent buffer overflow detection in the
> commit 6a39e62abbaf ("lib: string.h: detect intra-object overflow in fo=
rtified string functions")
>=20
> Here acpi_device_bus_id->bus_id can only hold 14 characters, while the
> the acpi_device_hid(device) returns a 22-char string
> "HYPER_V_GEN_COUNTER_V1".
>=20
> Per ACPI Spec v6.2, Section 6.1.5 _HID (Hardware ID), if the ID is a
> string, it must be of the form AAA#### or NNNN####, i.e. 7 chars or 8
> chars.
>=20
> The field bus_id in struct acpi_device_bus_id was originally defined as=

> char bus_id[9], and later was enlarged to char bus_id[15] in 2007 in th=
e
> commit bb0958544f3c ("ACPI: use more understandable bus_id for ACPI dev=
ices")
>=20
> Fix the issue by changing the field bus_id to const char *, and use
> kstrdup_const() to initialize it.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D210449
Tested-By: Jethro Beekman <jethro@fortanix.com>

--
Jethro Beekman | Fortanix


--------------ms060601090805080101070809
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
JTNkQWN0YWxpcyUyMFMucC5BLiUyZjAzMzU4NTIwOTY3LGMlM2RJVD9jZXJ0aWZpY2F0ZVJl
dm9jYXRpb25MaXN0O2JpbmFyeTA9oDugOYY3aHR0cDovL2NybDA1LmFjdGFsaXMuaXQvUmVw
b3NpdG9yeS9BVVRILVJPT1QvZ2V0TGFzdENSTDAdBgNVHQ4EFgQUvpepqoS/gL8QU30JMvnh
LjIbz3cwDgYDVR0PAQH/BAQDAgEGMA0GCSqGSIb3DQEBCwUAA4ICAQAmm+cbWQ10sxID6edV
94SAhc1CwzthHFfHpuYS30gisWUfWpgp43Dg1XzG2in3VGV7XrzCCGZh4JM/XQWp+4oxmyV4
2Qjz9vc8GRksgo6X2nYObPYZzQjda9wxsCB38i4G3H33w8lf9sFvl0xm4ZXZ2s2bF/PdqvrK
0ZgvF51+MoIPnli/wJBw3p72xbk5Sb1MneSO3tZ293WFzDmz7tuGU0PfytYUkG7O6annGqbU
1I6CA6QVKUqeFLPodSODAFqJ3pimKD0vX9MuuSa0QinH7CkiPtZMD0mpwwzIsnSs3qOOl60t
IZQOTc0I6lCe1LLhrz7Q75J6nNL9N5zVwZ1I3o2Lb8Dt7BA13VFuZvZIzapUGV83R7pmSVaj
1Bik1nJ/R393e6mwppsT140KDVLh4Oenywmp2VpBDuEj9RgICAO0sibv8n379LbO7ARa0kw9
y9pggFzN2PAX25b7w0n9m78kpv3z3vW65rs6wl7E8VEHNfv8+cnb81dxN3C51KElz+l31zch
FTurD5HFEpyEhzO/fMS5AkweRJIzwozxNs7OL/S/SVTpJLJL1ukZ1lnHHX0d3xCzRy/5HqfK
3uiG22LPB5+RjNDobPAjAz2BKMfkF/+v0pzn8mqqkopQaJzEAbLbMpgQYHRCjvrUxxwjJyUF
b2Z+40UNtMF4MTK7zTGCA/MwggPvAgEBMIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwH
QmVyZ2FtbzEZMBcGA1UEBwwQUG9udGUgU2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBT
LnAuQS4xLDAqBgNVBAMMI0FjdGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhBu
kmvE8GLB9+EYd88699DiMA0GCWCGSAFlAwQCAQUAoIICLTAYBgkqhkiG9w0BCQMxCwYJKoZI
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTAxMDkwODI0NTJaMC8GCSqGSIb3DQEJBDEiBCBG
hAwxYowrynRqkEng6rsNNZHLzRApsetA/+w5iJ9CoTBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCG
SAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqG
SIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGnBgkrBgEEAYI3EAQxgZkwgZYw
gYExCzAJBgNVBAYTAklUMRAwDgYDVQQIDAdCZXJnYW1vMRkwFwYDVQQHDBBQb250ZSBTYW4g
UGlldHJvMRcwFQYDVQQKDA5BY3RhbGlzIFMucC5BLjEsMCoGA1UEAwwjQWN0YWxpcyBDbGll
bnQgQXV0aGVudGljYXRpb24gQ0EgRzMCEG6Sa8TwYsH34Rh3zzr30OIwgakGCyqGSIb3DQEJ
EAILMYGZoIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwHQmVyZ2FtbzEZMBcGA1UEBwwQ
UG9udGUgU2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBTLnAuQS4xLDAqBgNVBAMMI0Fj
dGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhBukmvE8GLB9+EYd88699DiMA0G
CSqGSIb3DQEBAQUABIIBALg3Xh6ny9if1gUO5KKu56ogoGu830lRleFtcSvCVJ4UYCgsYGWh
/gZjv6Djw7THKESW+uUQTEQTnl1v1xRoIK2e+zZzLa21+fRjc803EadvoDVtXoY13Gx60Dfd
KrSeywCrtjhc6jAzMsIv/6ITYirPa9MusUxavwKioxPbJ1Sd2+XgqQaCpUl+GTrWbEbkNFoy
TCXIh8ERCpb3oqtEjVWxthuOKUPCcJPOOmVhf1/s24bDnZi70pL3oJDkzaJ38CxaIitMG+8c
5UNfjgC9L1QhwOWNZHYlEmryzVB1fb1T0Sh4VZJQ0f1NLs+/xM9oaUN4bZUQKqD61NPVFlIY
R9oAAAAAAAA=

--------------ms060601090805080101070809--
