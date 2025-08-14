Return-Path: <linux-acpi+bounces-15711-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2066AB2704A
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 22:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BCC91C87B74
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 20:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B99F26AABE;
	Thu, 14 Aug 2025 20:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="N51nCWkn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2114.outbound.protection.outlook.com [40.107.237.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70DD24677E;
	Thu, 14 Aug 2025 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755204140; cv=fail; b=siG/AdqQ3IPqTlXFDe2vULwFxDKH4hRoGLGSSZNR3pdlZneIayCDbKPGsV+yvr9t4dGNXujNXkS+bgKTOfksTOGSeea+xY1HicTKNj5jyr5IUdQkk5lFZPsAhr2f+//B+a8mvYeYsaZ5PZl7hQbxJIBYSSorjEmSu99f8SXTNmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755204140; c=relaxed/simple;
	bh=ZbW4X7big0VmbZpnyr2ZXx4z/uHPoEce+0TPPzYOvqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F5PMasSyweq/eQ62brEcFqxk1xOKKJ7PshiYij+yiiQei3GMfDis/JxmEbs2+euytH7YgITdb6S8s6atKys+HDW92b7WtcI0cawPbFfr74XKlsGdHLg3+t0GFS/aEgL6oRjOIEmn/l9W3XoRvRZBmqo8GA6+2bp/2sfNCozB5G0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=N51nCWkn; arc=fail smtp.client-ip=40.107.237.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wg69l6MBFjsA1KeDRrhvdV2mOboOp2lHgWcAVgq+FWzXf3FAyvmvu6JpuNj/J/EeAGISgVTgJ67w82F/gekCKml2+IKLogKwJcTMCJoLFIGLP6yW1xgeR+re+mqhuG0aTc2zCcdAHa8PvLlhwUZJT9w5vNR7oFosyaUg8PmHh4OJ4MVlNMUKhXxEOFTgSaoSuCJjqlREXQkpnq1pbRVycRu9ZYTupbklD2n6Y3ihQk9gNW62BiBuO5jmdEsWRxltJ9d7AYDD7qyRBE34HhSzFa7m4NQr6np0+S6o8a3YdfgnQG2V++xk9tNfQ8tKIZteeK1WkJgR6Ec2O3ec8o0DQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5wksn5JmPLzao6GZ8n3+x5SHhJMAndCn74h3H1/JVY=;
 b=HQ8Du/anfJ0sFXgdFlyBKy9LuNJ4FMEjLFqqo4YhlvTzo014ZVCi/SA7CVkyx+KhOGNZBkTy84hKXaOKoPoHpw9jz2YQ9o+qmXvfffaDWVqA1j2f6vBthBiBh9cVZDCHZaMmRGA3XY697OHGKvjmAqjNoox+/hnKSFJXZrb6vOHFuGLwyC1GE8L+mqvv9S96h78zylWTFP2+W4EDALCPPx2bSGMkud06l7myOLDKkcjBsvT+szgdRkHxbr5hbD+myHGXbfnFiOIavS0Bcm1fuYL6evRoaDega0hoA73CpPfQDsInMaouEiPEXBlljb45aUM9yyunfZW6x7V3ctdONg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5wksn5JmPLzao6GZ8n3+x5SHhJMAndCn74h3H1/JVY=;
 b=N51nCWknUo/FtW3dbW23pWvn2lgPIHL1Iy5a4RavP2+fOBgTcmNFVDirc55opZ535Z225h9cyeSKh5lNyuUCllRru9/Rl0q4TFNF/rZvyUJ85njPX7HImwsHi+aK9aD+qvRrKZ5/hJ2FTVH3mVfScy60g3p1UE20u0aiKuAWkJs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 SN7PR01MB7952.prod.exchangelabs.com (2603:10b6:806:34e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.15; Thu, 14 Aug 2025 20:42:12 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%4]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 20:42:11 +0000
Date: Thu, 14 Aug 2025 13:42:08 -0700
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: Tony Luck <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, "Lai, Yi1" <yi1.lai@intel.com>
Subject: Re: [PATCH] ACPI: APEI: EINJ: Check if user asked for EINJV2
 injection
Message-ID: <aJ5KIMK6ALKXdVmY@zaid>
References: <20250814161706.4489-1-tony.luck@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814161706.4489-1-tony.luck@intel.com>
X-ClientProxiedBy: MW4PR04CA0086.namprd04.prod.outlook.com
 (2603:10b6:303:6b::31) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|SN7PR01MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 4131136a-bed2-4448-454e-08dddb730b4b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xa8Ex18dOT6r1b6XEX0hjQU3HBqFzz1wBTHHV/vH075eL+HMVp54s1gNxHi8?=
 =?us-ascii?Q?foUGQF6e4tWQiRhdzH08UiBIGb9hgqJBF2NJ/7kAIOD5gIkHDZebJlsGA0tZ?=
 =?us-ascii?Q?5emcENwo+/DOipXagZUbAfy8LrKDemBLHTNbigtVqDfM/Yd1p+aEfFxGHXyW?=
 =?us-ascii?Q?8+EUb70sYfRB17OWVlnJiaCoWYhh35zAMo/lXWoapxXAPg9p0pES1Q429Kmw?=
 =?us-ascii?Q?5Ror/fIOBX53YUA+wuzxP8eDE88opFv7RWNwGI9T+We4e6u97hvAdARVEiUT?=
 =?us-ascii?Q?SpYxVZAtP2R8AA3YDInyvqrMwepjAhhc6fDYkeHTAMOfc8QTjXDOm0aXFOVQ?=
 =?us-ascii?Q?sY4jTGDJ6WayFPPaDCBDYyN207HW1WLm9F10JSSBlnRiv64N30T4DgQfqi/0?=
 =?us-ascii?Q?1DWJj2Q4fRlnMsMxVkB1rlPL8XTktPNCL5PkVnNgUaXlK8zKsjt9Gm7xZGyA?=
 =?us-ascii?Q?NaKRtQTBT1GJzL/pYybNzVcIAyUQ7BJZUIdaXjZh7UGPReYTWLBwsJmatCnk?=
 =?us-ascii?Q?bBw/bgG3JgQrn/RVU1e+wMPcOeUFiZ+lJ91DLfCw2uHhlIwLGS4vPJVD5wQp?=
 =?us-ascii?Q?TLCz1KS/SdDJS8MNAQ5biKFaxZkMJBdyZTBQLEvl3kfnijsrSIT71lmwA3X5?=
 =?us-ascii?Q?sb9WjFnC8OgE2sszYac89b1uOPo4wE5olOpaL5MUmiC/zb57MhGlxWSEWZQG?=
 =?us-ascii?Q?jf20a6/xlylaNcw6I+PayFILZcNcLwVmSkegtVtGpjF6WH+gbsK7c1b+rgQ9?=
 =?us-ascii?Q?6aPjsXHpPHoJoM7QuB0eHCpBcYpo3ux+cL261H5dXgu6exF3Tf2x0JKQ1fBD?=
 =?us-ascii?Q?x6dNQPKAbBXidKew8URwliJAJaLfC1ow7IOp8QjLZEwe2ud/VLiaQYNUYR0W?=
 =?us-ascii?Q?4N9hPA7Vby/SCI/fO9mQuM0+CMFFPYoxq0fUA1lngaqhA454wxUC6GNEqNzu?=
 =?us-ascii?Q?N3YivD0mYOeivOKuTqIw48oPwOcyn/zhITDXB9KtBsiuQ073Q5LQ7eb9Eq+g?=
 =?us-ascii?Q?cneNTq0wqDllm6UCzf01OQUDdz66uMZE81A3gugBctQTX8JTQNH29GaeJNgH?=
 =?us-ascii?Q?9NAGZSBByaQ9YkUKEfPe4iZxxusDzNLkV0+KHt1AXtTJ9EkMbrytthIOX9ZV?=
 =?us-ascii?Q?pYxK+7OIWTOzYLlWwgpxqeUPTKYytpfxQx1mIlL1gbOt3jf2r8g5r9wh8kaW?=
 =?us-ascii?Q?MIstkoFmI5SozvjJ36VUX9786PLk4tVAcWdDcO6M6hAITVEzMA28f8xfpSF5?=
 =?us-ascii?Q?8qS3RS7a184on8NSzecQ7N2NoM3b4lFQj4itUTITFZcZ7aMm6MNNwLImO+yJ?=
 =?us-ascii?Q?XaILfiM3ZjUBfj8fMD4iJI14NgDnsu1mT8hK+o+94zrkCbykVfD2x3dSLkId?=
 =?us-ascii?Q?pfAwmzp94RD8hDGfNaS4O01HL5M9ZufqPa3sZ6VqXL438bKVjw+6gNlywtHw?=
 =?us-ascii?Q?AfZLbJPJgwHwIMBWnjqiYUxLrcRAq+SapIpytA0Vn8ZHJVdtvn9UnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yJMWHAEM6ldLJeATTxHv02iyecarXe8wxPJIaAfZqaROLM+T2fbWR0rDXDOt?=
 =?us-ascii?Q?6RdTe4Jry9vaGvXgm/M7AKHne5fZrzz1UArZXjRwdHYFVPphPpvQe4NGGjsB?=
 =?us-ascii?Q?N4jrDFBcIbilu4QDPy73XO1SG2LL4GmMj/NEYKKEP+Rs3KVQsG/Sx5P5rOe5?=
 =?us-ascii?Q?YRvWSoHuChI0V62vc+H6hddgW4jJ/hMJBLVy+9vocT/NOby3R+eABVvy835d?=
 =?us-ascii?Q?s3+Lmb2jVJScbhRk7mk2ajsZBglLWKBF8PWtQC7Ub+eWY4E8FJL/5jJ2/5/l?=
 =?us-ascii?Q?yuDSIrN0PrUZwGF+vL70pGz2cd87sraCwbb0Ngu8aN5DC0RbLkBE3jwMekTi?=
 =?us-ascii?Q?VwLvmK7Qn4ttHSQq7nktPr3x7nkEtj5m7x833rVfmvV+PmijltWf97isz4Ek?=
 =?us-ascii?Q?CV/QQ1codk7T4MUi/MkqCrqoPEuVYLJXVzgpJRaM0j7xy/R0MbfC00GaxL9W?=
 =?us-ascii?Q?JAIx+Znxl13sySJkdSL5gIqzxfPtNos6dal8O+T9SnMxyJ8IwSh8g4n/nuSs?=
 =?us-ascii?Q?oRMQEKBYXA71SNwh86vRlOixhOaKZ0ZdbKT1n97ERsBB/7qEdWKb95NJmjhN?=
 =?us-ascii?Q?iKuiMkhWQaJ594vMtjnYVS/jjXLWnRLhlYgpz96g2G7cJNbeXk22FJGGzq3K?=
 =?us-ascii?Q?r6C//QI7QkhTCk8mWqP/EywQULPw0tb0SDUwVxRB/OvztOpIW/15ZYz3petm?=
 =?us-ascii?Q?eaub2Z2gfIF9sYGigJs5I6vSVJcQ7YN8c3eCblusadR0Xh5zLvuTWVfna9RJ?=
 =?us-ascii?Q?bmsMTguL89nG2QdydgdO8XmirDug1K0blPDtJmYhxkmq66Zknydtiop/sh+1?=
 =?us-ascii?Q?tZQ44CTF26b3qWL+wR9RsJl4opW/u3C8kKELkV3CAJ8wdOWXR7jgIonsnQUM?=
 =?us-ascii?Q?xGX2NgjOTiHKbg250qq5wenPlMCD97XAHa3LsD19lpnP0EpRfcJviI0+cC8o?=
 =?us-ascii?Q?TXVaTyj8ZdIGyuKSXxDIWGM/SmJI+dIDA/9vvojF4xHEz8z5zT03ivT9Sw5G?=
 =?us-ascii?Q?voHCkYmW1EjmlLaxkOnYx1oW3Wr4v4pd9YM1gCl8ou9Ue8ki2dS15oUdCa+F?=
 =?us-ascii?Q?28hmu0uGPCPRgHx53SMK1hnwdqYshxHk7OzaJjP7WkVKnyrFm/zVEx0EGKYK?=
 =?us-ascii?Q?DmI7di2Yj+RTDE153zAZYzIdke3KpeMrGISmc+HXbkil2PMSh4vyVO1p4Bum?=
 =?us-ascii?Q?4aIMD54hHiE0gFMa/asYA5rTrM/duxAQrf1NSUkIZUHN5DXN4sf+0qvoiazN?=
 =?us-ascii?Q?wazugtdhpsNBFvjpfoZWifJKuf8M9cFL4mFSoekxGpYNlmkKWc/JH3DQoykC?=
 =?us-ascii?Q?l9KyrI70/ytYLRuNVsG4mSrpD6KyXG+sEU8VlFD95GSMgPrAcVateWoK4wyi?=
 =?us-ascii?Q?ExlRzvIdSyn2L98cDQlnkWnE9TGMKvRUA4AKwAi7Z1r78tXaSm1s+IwFm+aJ?=
 =?us-ascii?Q?mwl22L1YtVR1lkrfHD766BVkliUM7vEhBjUMdjM9+3FEqsB88zKJMo4pBQgC?=
 =?us-ascii?Q?Sqph91O48RY4vGgfX3qJyP8RW5mi/+pN09G8HrBOfL9y25tICAMpVpZBYq5g?=
 =?us-ascii?Q?FXxXII9eewWaPou5ryQdX779zg1ySmB6BWSG1y7j98KjlW029l5M1Rm6fwAK?=
 =?us-ascii?Q?o4foEeVVlpzgKSbdzQxW8MQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4131136a-bed2-4448-454e-08dddb730b4b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 20:42:11.7386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TnvZ7ND8oBK3/KRDQlTrEqpqTVjoYHlsmLW4HQDyfk4d0m0prUnFLuAmtgd2Xm8VGJddLhRxMg2jhoSwij76ieba0xxXX9XDOhAouWDJ/7W3TAkklgEjKQnIHaHxX4ts
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR01MB7952

On Thu, Aug 14, 2025 at 09:17:06AM -0700, Tony Luck wrote:
> On an EINJV2 capable system, users may still use the old injection
> interface but einj_get_parameter_address() takes the EINJV2 path to map
> the parameter structure. This results in the address the user supplied
> being stored to the wrong location and the BIOS injecting based on an
> uninitialized field (0x0 in the reported case).
> 
> Check the version of the request when mapping the EINJ parameter
> structure in BIOS reserved memory.
> 
> Fixes: 691a0f0a557b ("ACPI: APEI: EINJ: Discover EINJv2 parameters")
> Reported-by: Lai, Yi1 <yi1.lai@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>

Looks good to me.

Reviewed-by: Zaid Alali <zaidal@os.amperecomputing.com>

> ---
>  drivers/acpi/apei/einj-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index bf8dc92a373a..99f1b841fba9 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -315,7 +315,7 @@ static void __iomem *einj_get_parameter_address(void)
>  			memcpy_fromio(&v5param, p, v5param_size);
>  			acpi5 = 1;
>  			check_vendor_extension(pa_v5, &v5param);
> -			if (available_error_type & ACPI65_EINJV2_SUPP) {
> +			if (is_v2 && available_error_type & ACPI65_EINJV2_SUPP) {
>  				len = v5param.einjv2_struct.length;
>  				offset = offsetof(struct einjv2_extension_struct, component_arr);
>  				max_nr_components = (len - offset) /
> -- 
> 2.50.1
> 

