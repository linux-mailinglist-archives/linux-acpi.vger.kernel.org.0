Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB121D033D
	for <lists+linux-acpi@lfdr.de>; Wed, 13 May 2020 01:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbgELXxM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 May 2020 19:53:12 -0400
Received: from mail-dm6nam12on2138.outbound.protection.outlook.com ([40.107.243.138]:51040
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726031AbgELXxL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 May 2020 19:53:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcSHZ6Dceyile9HxpMJ5MTPp+rR1DeBTXaBRCIa50g2TOqE4TzwWeEg/T0BQi49tL3jp3p6Sy9cjybsiUfs5eIVvMoQ2KmGfFqGqaLid6zOASJ2ib8p34OyMZx7zv6VAZEhWxfibMENPakLQDn+hMfuN3OqhQ6g8aRIqSzEYuGof1zA0mQ860EuGraHO2JhV+Ew5nkJq19P/LoZPxw4cbw1ZWKM9ID0t19wO5uty0gw80vr0byHLeykTCKJWuLDmSqngDkBcjkeizjUqaM9Dx1ZIrwnoI57U+kwjXlRKptJzX0uzAOGI/zLyk8MCyMM6KqJjR6khBjSaVJcnPPu4WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0aBwdb7zqKc1Obho3m8bFWIiOG39KLuqKVgI8rVHLA=;
 b=iXGyCBmEW1FbV8xlCSNz19p3Z1r1CFDrC1zBYhreM1reAnjTgU7xVMA5G6n0O/mFRmAGqNGGclywfyDsW7cSrng7+NQcDaGb0liPEMjguNGttW09yb/RnaTOX3E03SXzB7Q81NXtdFcq2brnV6K8eiMEzjx0HoP87HtKjbsLHEuqLlvDqKBl1OdhuMpZ5aFVgsUP9ZIWoXLpRq7UT2kEaS6jv5XZJSn7kvhuKvrgTcbdEmc4kck1roUAWN0iY9oJKfmNzKNcBIiOpnaBLZCRWOy2vRmum1anNiwp1XeUGeBCs3C4ebwn2fQ2rmwbJkFTTQnWH1fSFuXe8AWJB6QHQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0aBwdb7zqKc1Obho3m8bFWIiOG39KLuqKVgI8rVHLA=;
 b=NgQsBErTZMy+Mj0f0m/O1qd3iDNsx6625A5Ao2fd1SE+jrKODgS/i+Iwx2BKhE0G7WOYegFm++nX0Kta+9COhlsimRy7SOObc3u9FHzmK7caKBlXP7G5WIrQocWW9MTQrS+T4Dt3gMI7i3yAZs5utI3RJlpnq2AiAoe5rn/WLnI=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none
 header.from=amperemail.onmicrosoft.com;
Received: from BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18) by
 BYAPR01MB4151.prod.exchangelabs.com (2603:10b6:a03:58::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.35; Tue, 12 May 2020 23:53:05 +0000
Received: from BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::296c:b848:8bf0:6f2c]) by BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::296c:b848:8bf0:6f2c%5]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 23:53:05 +0000
Content-Type: text/plain;
        charset=us-ascii
Subject: Re: [PATCH] ACPI/IORT: Fix PMCG node always look for a single ID
 mapping.
From:   Tuan Phan <tuanphan@amperemail.onmicrosoft.com>
In-Reply-To: <20200512104030.GA11555@e121166-lin.cambridge.arm.com>
Date:   Tue, 12 May 2020 16:53:01 -0700
Cc:     Tuan Phan <tuanphan@os.amperecomputing.com>,
        patches@amperecomputing.com, Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7A334798-5657-4E43-AF81-C8853D248744@amperemail.onmicrosoft.com>
References: <1589228576-18053-1-git-send-email-tuanphan@os.amperecomputing.com>
 <20200512104030.GA11555@e121166-lin.cambridge.arm.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-ClientProxiedBy: CY4PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:903:18::14) To BYAPR01MB4598.prod.exchangelabs.com
 (2603:10b6:a03:8a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.173] (73.151.56.145) by CY4PR02CA0004.namprd02.prod.outlook.com (2603:10b6:903:18::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend Transport; Tue, 12 May 2020 23:53:04 +0000
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Originating-IP: [73.151.56.145]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ff704cd-494c-4491-94db-08d7f6cf9d41
X-MS-TrafficTypeDiagnostic: BYAPR01MB4151:|BYAPR01MB4151:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR01MB4151CBD4F218D68EE92AC5A4E0BE0@BYAPR01MB4151.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QJAv6CJfEKNnm4nDyk0buzROFabUY9AGWPdkz/dE/iwwiIyVCXV+oi3p7ustAdXTDlCLewu6lypeYUzKFbg8BmGKljQnP/zar7o9ugnz11tnKLdiL/tk08TE41hCFylGKMIzucRcy2pFiAeJ8emvcARPuR0s8Smr+fiXDfnaT+PnWKpRd3P8NbGVBA2gX9Xtd4T2Sbc/cFV/dA3+ImEoXq6BJ4H6E00BEJZ4fMD40xbW98BvbZJklGGf2A/tUdJFd7Zfv1KAf1BAzqnPTmYu5ZiVc9zT2MC1ICEwdQ+cwNZxlx7DTGK+o8zOToLYzoE1z4Y/bjm31rSBAh3xpOR9+Q1ybx7cpFRQnFi/MMkDWx8+V6ugpYXVwXo3HmAHpDraTMAhubQkUDj1GsulBqDr90WAlqFv7wR5UmdoNe0JCMvoatU/kNwYDI2JJI8WodpWQmheY3U1XJZYNdax71w2Pl9UKEVzFScrEQyxSSBSAJL/05ze1vSM11aCHAYJuQ9zr7ZlsLhcswMsSwHLiZZCMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4598.prod.exchangelabs.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(39840400004)(366004)(396003)(376002)(33430700001)(6916009)(16576012)(2906002)(26005)(83170400001)(2616005)(316002)(956004)(33656002)(4326008)(8676002)(6666004)(6486002)(16526019)(8936002)(33440700001)(186003)(42882007)(478600001)(66946007)(54906003)(66476007)(5660300002)(52116002)(53546011)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: OYbMgTH1kS35hMiEki8h5WDHO4AP2NWPSZ35cqfTC1mltXlLh7cbEqYpSUXLyQzqxN/Iw/+fRIiYO3PhKtY3ZDycqUD08DgE/tG47nrSM5rYyR0Mt1leEqT8pvjPvMV2tI9esosbjaNPcLnN3V6Npy5QCFnVy6QzYnIF/FoM9120CIrBd7q9XMHPQ6Ji2Oq39B1J7mZbA/vwsXn87QJ7yBa+FlH2pkS3zTB5pt68M4G8lYymGBch1NNaFJ9T8Q1t8GHAuhf1mpA7nB7os9Pl99QCnJ9wYqZwPH9XGcTBvWIgqW206FU44mu4v01UPSNkSTTxsnwoLdefKIgzs35yI/osK3We8NH+g5u72k0eH6IzrM290O+aWAJAJ4Pkhgvo+KMCT4OkgzcY1s+mnRuNpn3Olc4lhNI35xgp8in/uSLQdM2bB34YWHkhjLlc6WF5XKJoVapugs9BLT7VY7HFik5KojeD3ngt8TNvKcRd48U=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff704cd-494c-4491-94db-08d7f6cf9d41
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 23:53:05.6222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CimboW5Xq79mZ2gVPf+xjKBVmFt9qqP7PYLto82hCYE0hbG26nZOPeUiu+UDQ1qCUKddLV/4FpArtBkFwVkeQS2l+hKq39Dr2jHEblDc/M0Yjm96lBntCYPQnr3HULD6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4151
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> On May 12, 2020, at 3:40 AM, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com=
> wrote:
>=20
> On Mon, May 11, 2020 at 01:22:56PM -0700, Tuan Phan wrote:
>> PMCG node can have zero ID mapping if its overflow interrupt
>> is wire based. The code to parse PMCG node can not assume it will
>> have a single ID mapping.
>>=20
>> Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
>> ---
>> drivers/acpi/arm64/iort.c | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index ed3d2d1..72444e1 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -441,7 +441,9 @@ static int iort_get_id_mapping_index(struct acpi_ior=
t_node *node)
>>=20
>> 		return smmu->id_mapping_index;
>> 	case ACPI_IORT_NODE_PMCG:
>> -		return 0;
>> +		if (node->mapping_count)
>> +			return 0;
>=20
> Check struct acpi_iort_pmcg->overflow_gsiv to be coherent with SMMUv3
> code.
>=20
> Lorenzo

Sure, I will fix it.
>=20
>> +		return -EINVAL;
>> 	default:
>> 		return -EINVAL;
>> 	}
>> --=20
>> 2.7.4
>>=20

