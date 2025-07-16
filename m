Return-Path: <linux-acpi+bounces-15183-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C25C5B07325
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 12:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B292F1893388
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 10:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F2B2F363F;
	Wed, 16 Jul 2025 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="IXSdBJOL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Isu7DQLR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EBC2F2C56;
	Wed, 16 Jul 2025 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661136; cv=fail; b=bOm72Y5DfUqtIaYJpqRmmtMAzG106x+12sgoqbHfYRpjuF0ZI4E7Qp6nIehi3MAcmQtCGVVTeVASEZphL/lx8I4H1rjY5SnEHxFk68VpNE3UnhBz3Mi8tdh/9taVPWgL6V16ibmlfeEssRhV8lr0PjsQ0JtRYrsFDtOpecBaDKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661136; c=relaxed/simple;
	bh=x3gL9h8FD3DE5KG3pYsEmq+kI9Eetyf708n425tZu1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AklHTc8+fxdOj32ljwiFZpk+nJaRp7VAAG4ArjjmrpoqVQAT/BHoZf9GCDtIJcyUEAqttDfYvI8t+7OST4W9S0j4XK7QhJuS4fdr8VDYaG4DLlA2tzpWy+Mg4yYjXt+r0+GiOY2SWMKmW6uFJy4l66LzUoNd1S1Hwfne2a5UkOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=IXSdBJOL; dkim=fail (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Isu7DQLR reason="signature verification failed"; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G4UV2U029353;
	Wed, 16 Jul 2025 05:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=/5bPmf31MkHEyE7cD7phxofjLzRYFrjWnyXCXyaNlX8=; b=
	IXSdBJOLZZR8RF9lTmZFo1vZmxCRJM47ly+YebsduzEmVISU0VqeyHVOkV47ucIw
	zG+11Le2FFUggxGM84fALuAFRaRZ9fKByI4ykzvbdAzQ1JcTniVwv9JzjpYoFlvA
	8ma9rPV3vPNHPziwnnOV8wqcN3wNpnc5DOPT502zum8cCDnU0x+/uW5vCJdt3QVj
	RBIvLL2O5VWWWNTnp2lm1MhjGbqyDkl1VK2oBkoF/2joc96Oir1RBtazjMRjRufb
	yYkMK3JOTyVEX+EPQ4SHaYh8Huv5276ofbp6fTAkc69xBslQA7qNlkjBJsc5efYe
	dVijZKNyw7ozxpiKS6Uybw==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2118.outbound.protection.outlook.com [40.107.244.118])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 47un42dfu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 05:18:51 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvgzNo+Mr92C+dDbVxYcL+bA9rBP1IUFifI125/OJV0rhst5gWrUq+cl0HyZSV2TPE5GBrNmP9y/5tVjORhZ7/byd80uSqhXo1I68e//MrPExLG8a2pYS8SfbjEUPXfG/MmX140aFg8E5oec7M7lHFdxWAY5rtixijmDP22Ni2Ie/NIjKjHQ77yr6UrQ+riEMhjZoiFIrYok2PP9sPKlqRVZE83d4RU2q8iALR5ZJGfyswr+JLuu3WCVayXQliA2n4UAwl2nBud39qG6DQ9XOoRRvGeES+Zkmq1/l1dcToWjwZbVVO4AV3MFScUdQdsWXwed9Bv8Ht0JgdLrAaOSzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orcjX3jQ2VLTAtYRDEQ8hLopYXEhvR+RC0zrBW/UzAY=;
 b=AR9qZWufvr81fVRSu8mAzD2bRVuvvNAQCxNfHq2OgMhrP0+nMUBHokRO8bR7q8hKZFoS8yFwQrmCrOdrGCK7t9RPSNx310Vi6CngC/5zTEBxJEB/hrInEx2Oq0re/9apjbcv+6JWbWnQqjQreeRF+wICkHNTotuXKY9iczW3Gpv12FD7SJLaRcKfRfILsWWY0ujpgEipFLTUqOyyLTNN3UXUIzxMZvLgA48o/MV8HSVp8YFXja5ZFFVjULInqhyjipmHKW1j1/ZfnHEm/Aldt3NSaEvTzfDH6sCayqK/U9IOI+V57Wq5Fm+LTXy5JKASYqkH+Ayn6MtcMiCzmVAdew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orcjX3jQ2VLTAtYRDEQ8hLopYXEhvR+RC0zrBW/UzAY=;
 b=Isu7DQLRHj+/QORtdoYiagCerGNiI0o1yvaPFqCxXy+5nzlx55iApT9rk8ooCt1uFU126jY++NErJK+NmZha2YW9bJwkb9Fh1iZGBCMdE1qm3xpU6t8ja0YVyGkSghF/XbWcqIIXOKXGTjrbJCdPR3Wq7ZBqxDCXxiyxHM6co8k=
Received: from SN6PR01CA0009.prod.exchangelabs.com (2603:10b6:805:b6::22) by
 CY8PR19MB7132.namprd19.prod.outlook.com (2603:10b6:930:50::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.16; Wed, 16 Jul 2025 10:18:46 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:805:b6:cafe::77) by SN6PR01CA0009.outlook.office365.com
 (2603:10b6:805:b6::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 10:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22
 via Frontend Transport; Wed, 16 Jul 2025 10:18:45 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 6CEB3406540;
	Wed, 16 Jul 2025 10:18:44 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 4CC70820249;
	Wed, 16 Jul 2025 10:18:44 +0000 (UTC)
Date: Wed, 16 Jul 2025 11:18:43 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v2] ACPICA: Add SoundWire File Table (SWFT) signature
Message-ID: <aHd8gwS7TIhC6HMV@opensource.cirrus.com>
References: <20250716100337.652657-1-mstrozek@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250716100337.652657-1-mstrozek@opensource.cirrus.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|CY8PR19MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: 68e05780-8aea-4b16-c7a5-08ddc45225e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?7pOTG0RoFMZobbRXOBnbY2Fa9bCZ+wwFGsTnFKMVf1r42vcSXQ5HJcpCNi?=
 =?iso-8859-1?Q?QH0RI5gM8HJ8rQgTgDGp4ekHtBj1lcugcy9rTJdfBx0LDdPvZ3jXb5K8/v?=
 =?iso-8859-1?Q?B2vTVCAS3WcrvtTWVarZnpaCoe5gc2AhMl0Kh7nEAe6MsstsrtercvTzKA?=
 =?iso-8859-1?Q?csfB3eMZXoXMOCTPYfyCaCBnGNeZ4Qb3Xkk+Zxd37tK2Jg4/OY4i2aqH8M?=
 =?iso-8859-1?Q?1tu9YtW091zE85cf8kAOOSoRz7fG6cnz1Y5odZMD/2H2d4UEvHjP6WJ9eA?=
 =?iso-8859-1?Q?46K7zRIcJwMiW9YqpLf6fYhZR33Hs9zxNRlTd5mRR1oHnaWvbP1Yqn78we?=
 =?iso-8859-1?Q?AbN9ncEBlI4f7oH8lng0Zo2G1iKqdnbseAMK141nq/1hYN9NdNZp6G254r?=
 =?iso-8859-1?Q?1kVu/4x90Oja0yvWFhCjokr6e/pD0IqitSRUkuEwJ2XyoQ53ubgnBVjhAe?=
 =?iso-8859-1?Q?VOT/HJqbMMWjOZ3NfS3GkBfCoJ4lyL6ym0WG/3lY6HQ2kfaG/FdWc4Cy7C?=
 =?iso-8859-1?Q?C01h/pozDJH8qF0Gh0190vQYdRwBT6aLmVmqQ0gYIhYYUOnkRAtQW+i73F?=
 =?iso-8859-1?Q?sEs1ipAibWNdAqYnKJVwKnDM4mhzruvzCdwvBA1yBuQNLcQib2lWcpnm4e?=
 =?iso-8859-1?Q?uEgKdwQ+DL1nSfg//4A6lDRK3c1YOE3YT+q2lXrgjp17M6UVwIRV7HVvgG?=
 =?iso-8859-1?Q?wdSKG8foMM5iEcnMv8cslu6NbgB/r0/ZqMP0uPCReSSePMqThARvSvmuHr?=
 =?iso-8859-1?Q?1ioByO8vERMT8nxcedyazv4BI6EJyNirv34N/MMBcXMqopFzjMYsAzeauS?=
 =?iso-8859-1?Q?B6GfCyJES+OxpEg8HOqioiWWd3cZtvI9uMMgU5mATYpTOR/6BOTN7xwgNr?=
 =?iso-8859-1?Q?IRCSAZdPneMlE0ijhUcOOHP/ImkqSyZ3VfMXTCpgbJhEf66D2xy0Mj1H/b?=
 =?iso-8859-1?Q?ipeDItzKYMlT4YbjL/dKRt5al57SPWnrRYDCFNv5D9gJoY6f2/zz4hS3XK?=
 =?iso-8859-1?Q?ovTV0CxKmlfmZ9YSr4rbeUlnJIp3sHZJbAJc6oTthSOTJqA3dd9dsildin?=
 =?iso-8859-1?Q?ITzqzJDmC6k86trbb1BB3RlNwnxkD5e62EA2AHvr/+Ok+Jo1c2EUX6Q+o1?=
 =?iso-8859-1?Q?agSx3t7JzeO1+esIQIxUxq+FdmymRNA9om8J4sHNn18AmSKgBGjdyLraT+?=
 =?iso-8859-1?Q?3fejmqi4StGividri51FyDW8fJK3LCS059MvrtVwcfjbDW3N7/RNhbUthX?=
 =?iso-8859-1?Q?+T6FW5yCkIyFUetCXBHy73evrgwEcj35Z1x6V7JqmFmDre3KvOZuXZ3fts?=
 =?iso-8859-1?Q?copyA8dbU6ojdampA6Mo/6ms3f0zXgidg3ethYXzixLSSqe8qJCo+nCoiX?=
 =?iso-8859-1?Q?NYMa8v2AuMiWfknr44qMBP5iSIKCYXClleHE/nxfwUipeJqUD1dKnhNtgP?=
 =?iso-8859-1?Q?SvxYdHoVpoCaNF6HGizCjFmLxmKGPn0cih8ErbXpGILSKV57w8jwVQ5sj0?=
 =?iso-8859-1?Q?YvpszWOAzmibt5Gko0IaGfgW3pW04DvkB483ZgLSlthx52xLs+76dm1wiJ?=
 =?iso-8859-1?Q?64oqRfC55XhuP7BPeRFvrFfn7xDg?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(61400799027)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 10:18:45.5686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e05780-8aea-4b16-c7a5-08ddc45225e3
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB7132
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDIwMCBTYWx0ZWRfXy5zDpuzNDyiu XOTOqfSWzAdN8gmbBo2Je8/NlHdUbh9A+3xQXrWj66GR5g/D6myJVTD30OhXnV3gl/cywf/noTU ExwzW7qeTp5YpMEcIdawX6njycOg2UYuFjvKbTK+C0WnGNubVdzB25yDppemdERTERPvFDAC6e0
 5j02lrjynHiLQWf185toDlgkO1cVzJHG3GK0yI8qOCwM0SLkAuXhj8Xp5+z11MMCFnRiJhjZmcj xYsGS0ACZgdlznmPkiyCNy+us4N7t9KxVTUqBHIFatcGrsEEwtYxEs86UIy3A9hZML0y2hz/39A aSoDu0iwViZGe1Ics93vZpvmyv35TU72SndUgKkYi1qRtsKOqBLk6s8bDmN4Y+n4kXxwh6i7gF0 g6mP0xk+
X-Proofpoint-ORIG-GUID: 0Qdw28GZPEFJShFRU5KQXcMJ9tsZBJ4e
X-Authority-Analysis: v=2.4 cv=F6tXdrhN c=1 sm=1 tr=0 ts=68777c8b cx=c_pps a=kYxjtQCH8jYJXwz0hAM5nw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=8nJEP1OIZ-IA:10
 a=Wb1JkmetP80A:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=JQJDhRPD3OthYt_GnVkA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: 0Qdw28GZPEFJShFRU5KQXcMJ9tsZBJ4e
X-Proofpoint-Spam-Reason: safe

On Wed, Jul 16, 2025 at 11:03:37AM +0100, Maciej Strozek wrote:
> The File Download (FDL) process of SoundWire Class Audio (SDCA) driver,
> which provides code/data which may be required by an SDCA device,
> utilizes SWFT to obtain that code/data. There is a single SWFT for the
> system, and SWFT can contain multiple files (information about the file
> as well as its binary contents). The SWFT has a standard ACPI Descriptor
> Table Header, followed by SoundWire File definitions as described in
> Discovery and Configuration (DisCo) Specification for SoundWire®
> 
> Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

