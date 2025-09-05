Return-Path: <linux-acpi+bounces-16437-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A181AB46472
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 22:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A35D516C939
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 20:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747E928C847;
	Fri,  5 Sep 2025 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E8T8RvoM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZF26Wdap"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4793028725D
	for <linux-acpi@vger.kernel.org>; Fri,  5 Sep 2025 20:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757103320; cv=fail; b=txAgYST4gLv+auWtGnNSZlTxFQJZiRqhu16tSDjNoOvNypovIOS5bLBZ/bPS5E4A7mNkbRH3eocxkZP1NtgLo5IbITQNK/oPliHp2umGizfzfgb4sF2CzMdiUShk+PmnE5uza/5IWoXUhwTF5ttWGcQDY4oEN1X9rOG7gp3oOCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757103320; c=relaxed/simple;
	bh=YbBdIblc4fo1mmTmS4iAjKGkVgwUQBQ8l1/AtWOqct8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hk1CtFO2YkWQREKSXCLPdVMITWT7MX0Z6oJtbxMBnmyLvYwkC7B8cNhuz2hD/r9pMq+qdtLDfHmOlWUKNQf6cIpYXCq5VcIefqttsO8sBmcirPptqzCbNlzJhOtyLz/6h+LYBM8ZNBBKgDf3Bceea5F9uW+ZO2P3QjPABE4sUuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E8T8RvoM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZF26Wdap; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585IJleQ030477;
	Fri, 5 Sep 2025 20:14:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=boeqE3jx1SAymr1lrjNFU5HeLxlxBuGjDAmFPEH1+iY=; b=
	E8T8RvoMaqlMrc6tMinwVM4+1JAvwjYf8dXx7+QptwWrdskxOQ4EI8naZOKfpoRJ
	CBYjnTGPGDb2131av3zYNvnSPgpdF9oZbcHw1HlWjVqCI7RYeLRRwUZQz8dBPqVO
	Xn8L7AnOPODmMZBJ3z5fnnqVEob+U+rQXO2xM++ECZm9hWcSJHwtYFLLhJGwxpHr
	FmaqaxLmb4asNxvgNbdGCWxkhQ/4OkUfj/8t2Wt0ht9geVQdoaQiKaaxhb6bsLVf
	eZxP88a8d3Qa4aAkcB+WxD0GGJ4H7EOlgZVXFtUM7b2taaJn1drqWgaz1mscyAJX
	z2Dr9chHN8ybMEwIey7Geg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49051sr6t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 20:14:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 585Jg147034372;
	Fri, 5 Sep 2025 20:14:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48v01smbef-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 20:14:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INnt3uYNUbTw7XQgL8zmnbuvYUwMjIdeEU5HIQuCRxb8a3KEeeoJIUm9WEAzfq7FAk1AsfwSHmFG0Es5ryygqLp2tlUs9OeKaoIYJ8OK2mXDKSHit4hGNpAuS4rKJ5wAH/QrtcP6onsZa/VaPUpbPv/nbTM2GG9Cm5l15lv4a0oNJTYujvcJglCDqFRZayvLddE46f5m+D3/hOF6ENes/ZxQe/YIb/dktd+r+JHlvYIkzQCA8yHnr9Ewa3fNs30vo8rWnE+L5D9LUaBmSiY3qoxUWk0OIfnQqOtp69hgQspd57rhV5qtCJfQb1LlqrD7oRc+P6mG7+Lg4j/J3PsKMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boeqE3jx1SAymr1lrjNFU5HeLxlxBuGjDAmFPEH1+iY=;
 b=OCnu/QjMT6eoEjKcVxl7flRI8zRZLktM2RFYH5v8ZJz2IRbRpWKKME1/KoXOK7hYCQF8+o+k8iWzlY8ygWz8RcX/Zp/71gV9KFjv4coQycQ+maOoGFmxZST31DqFV3/b1/G0qegA7WGyH74zKKWlnALo9pR2UXBpxjzzMvjgAw+in+f+wKJV9HOXVde3It26k5T3LdCLSb/hnBkWbrTRVKU0HBhpb6beLemJpuArtkhcD+pO0Unr6elRYlrQfIm5rASmTYaOzkoNkBdLRUzT28bakeq1NQDCSoikgvDBzfsMgKy7mI6OGcQ9hRFnypUFDpKfOOlw12FW6h5knsYEwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boeqE3jx1SAymr1lrjNFU5HeLxlxBuGjDAmFPEH1+iY=;
 b=ZF26WdapSR5/Q50YO+PDs3rCgvbl+vkzMGXeXQ7rAxZF4dP3LVw9rt5BMICSkgQDqYNI6eI9r1/pmmBuPKzbm5wGB7IqA9qR6Rg1QYADdPHvgVxnaIdE82o67QLX0GIBi4tk8Rp2jYMPRSppuqocuame6s6S9h4lwyu16F6WAso=
Received: from DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) by
 CY8PR10MB7316.namprd10.prod.outlook.com (2603:10b6:930:7a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.17; Fri, 5 Sep 2025 20:14:35 +0000
Received: from DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::b7d7:9d3f:5bcb:1358]) by DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::b7d7:9d3f:5bcb:1358%6]) with mapi id 15.20.9094.015; Fri, 5 Sep 2025
 20:14:35 +0000
Message-ID: <698d9758-a22d-4d70-8b56-54efcc453f2f@oracle.com>
Date: Fri, 5 Sep 2025 13:14:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: PATCH v3 ACPI: APEI: GHES: Don't offline huge pages just because
 BIOS asked
To: "Luck, Tony" <tony.luck@intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "surenb@google.com" <surenb@google.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "rppt@kernel.org"
 <rppt@kernel.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "jiaqiyan@google.com" <jiaqiyan@google.com>,
        "david@redhat.com" <david@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "Meyer, Kyle" <kyle.meyer@hpe.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "vbabka@suse.cz"
 <vbabka@suse.cz>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Fan, Shawn" <shawn.fan@intel.com>
References: <20250904155720.22149-1-tony.luck@intel.com>
 <brfqzhbipg35twgv22vnnotbv3t3grwh2dxugvtbgqduuhsvst@f7exibz7i7tk>
 <aLsHh70jI6BGHjaN@agluck-desk3>
 <bwu744g3qzbzylxvfgt7v4tnf2k2eosqbkg7alm6u5roa7j3bn@gmut2l5227kw>
 <aLspJ5Tpqp4qRDk2@agluck-desk3>
 <cf05bc8e-fc79-49e4-a90a-47e661b4ae69@oracle.com>
 <SJ1PR11MB60830CB47549119351B1DF73FC03A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <SJ1PR11MB60830CB47549119351B1DF73FC03A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::17) To DS0PR10MB7364.namprd10.prod.outlook.com
 (2603:10b6:8:fe::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7364:EE_|CY8PR10MB7316:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b6840c-c6ab-4dd0-9b51-08ddecb8d53d
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ekpBelptQ0N6VFpIY0pYSmpwTjZKN3pOampEOERpeG1UdG5BclhxdTQzSGF6?=
 =?utf-8?B?Um9WcHE5N1dzNXR0ZitqbG10RUg4azd6RTlUT21IOVk0cUhSOEpZQ0dpRlFM?=
 =?utf-8?B?Zmw0UkN2MU9FRWpJa3FQYTEvcnFQcnpZMW5waHkrYjVzQ2NZenBDNC93Rlc2?=
 =?utf-8?B?MkYxbnFkeWJnUXQ3Y1R4V01YYlhSSlpFeEVULzArWTd5MEg5SmxzNzJla2dI?=
 =?utf-8?B?UmFrRlp0d3RtUUt4UjQzN0VRQTlyQkFZUENpUGlERnY0azVZQ3M0a1MrS1Fr?=
 =?utf-8?B?NjhVMjc5eVRiRW8yakVPSzhLWjBWSWQ3VUNXanpDbE5HUFFTR25XOHJhOEEx?=
 =?utf-8?B?UzMyNWxnRkJSak93YlN0QWE0bmhyT0JzZUJkVDRPTnhDeHROQkowRjVCWUxo?=
 =?utf-8?B?WnhwMzFFWkJrSWkrTDdZcHhMZ21jVVZsRS9sdTBsRDR3ZGVxUHhCdTgvQ1NP?=
 =?utf-8?B?RzJCekxxM3ZTdVZlS3VKOCtGRkx5YVVKY1JWbWRRQ1FzcU5XbUQvZCttV0Vr?=
 =?utf-8?B?YW13aUZIdlhIZ0RocHJyTWV2QjhvYS9leGNnL2gwYTFhK3FXLy85U2xmNU4r?=
 =?utf-8?B?NTNBc1BZdXhSZms1VEpuWkgxVUQ3ZU8yaHF4bngzR0J6NU1CK1dmNk96dXNB?=
 =?utf-8?B?Z2F6MkljSjhFdm5GM1JwN1pmanU0ZXI4UmkvNmJhQWlMZXZ0bmtFRDQvUlhB?=
 =?utf-8?B?ZklYblhrMW5HcmtyZGlaRHFhQ1JySHpyZVkvdGVrS3pMZytMZW9ZdGNlUWFZ?=
 =?utf-8?B?aTVZdnFtbWVPNmszdEVnUUhlN0c0UzJhdjM3dXZUN2lhTUx5OHlrSURxTmQ4?=
 =?utf-8?B?bm8ya01pOHhyeWJzYjRZNS9vWWdPL0d5VzBrd3NzcEdMN3k5Tk1OYUlZbXh4?=
 =?utf-8?B?dkZUZURYL2hvT3lUWmVWWnJGamhuT3g3UlFITm1TVS81S0ZGSWxBTVEzbFF3?=
 =?utf-8?B?RG5XL3hSVVRhOHNnVC9JWElIM3lFaFpmOWx3T3IwU3R3bHhSSE9WQTZUL2tv?=
 =?utf-8?B?NGdKa1l3VENTL25pSzJLVW9MMWhTNmtyMDJKaFBUVkJLUzh1SXliNlRiczcw?=
 =?utf-8?B?S0R3YWdyT1FtQ2t2b3BRK1pyNm5vSVorYUw2N1ptTUlEUmdTUWxyckZFMHJ4?=
 =?utf-8?B?TTRyT1pMNVY2VTBQNHFaejlLcWl6dHVySWw3Y2xRNTJEb0NjVUpZK0VKdElJ?=
 =?utf-8?B?eTlNM2xzclZqR2tJYVdKcTJOY0tHLzI2TjNMQXpDVGxiQ0NnME9Oa3ovcm4z?=
 =?utf-8?B?Nkdha05yOXFabS9lYlNLbGQ3ejQ5V3k4SVozdnhJMEt0Y0p4WG10RWdDT3h0?=
 =?utf-8?B?RjNWVGd2cEdEaUxQbW02MncwQVgzS3FXWkxpYVRlcmZEaFdIa2JpUlpRMFpr?=
 =?utf-8?B?UjRUc1p6TzVnSVdGZ3ZINEhhQytzaTV1ak9GdTc1S1BYaS95ZjZvS1c2THVv?=
 =?utf-8?B?UUZEKzFOd3hVYUllMTZJa1BSYjhRbFVqemFUSTNQOFk1TjlqdEhDNnlLN2FV?=
 =?utf-8?B?bWNCbnF6dFJUZTlWaFdyS2lrR1krMDNPeUtqckxCd1ZTdW5PZGg3S2ZWUHZQ?=
 =?utf-8?B?OTNaWUduNXdEUXBQVjFVS00wY2E0YnptUHlROXVhcWRvcnJsT3p2R2VJWlY3?=
 =?utf-8?B?WUZ1MzlUcVVLR1lHdDhlNkNpWEIvN0FlUmE0K2lVRG1LK1FKVjlvLzNXSURr?=
 =?utf-8?B?M001dWdqb2pRSXZLaTU3cWh5OENQZjZJODVsWGJHVVZoR3h2bDdDSkNaVzAv?=
 =?utf-8?B?T3NRdFJOc1Q4UkV5UWZUOVJ4Y1djemZsMlJiYmVSRGF0bTRaVi9tenl3WUUz?=
 =?utf-8?B?QjdBT2w3UzFRb1loVzJ1TG9UVjRMMmpLM3h3UmZNZmxFaWJZZlFxS0R1eXNn?=
 =?utf-8?B?azJyRjN6cHVpaDNSUnlpM0pQVEhKQ1lTMGhPSlRYM3VoNHpvcVZMRUF4cjNi?=
 =?utf-8?B?WDNYdXhsbG1WU2FIVW9wdUxPaEgrTi9NcnBvbG1OLzR1TlV2azM1K3cwSWc5?=
 =?utf-8?B?T3Z5Wi9pU3ZnPT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7364.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QjZiM2xsWlcwTGtKa3JaOGh4bks1U0tmR1dJSC9iRHFEUXprZHh2ekR2S21Z?=
 =?utf-8?B?MUxXcFF5VWhCVU9Oc3hPQmt6REJKRVI4Vk1KL3ZpOFJXVE4yT0Y1Q0xMeExD?=
 =?utf-8?B?S0xHZTFqQWZVNUs3QzFHK3lZT2FQZVdmcUtHM2pKWkNaQ0ZnWHpJYXk4TkhP?=
 =?utf-8?B?bkFGUDZSYkpSRWQ3NzZkS1Q1WUNXMWEwaWZ3VW5MaWlJNm1RdWJPaDV6YVpO?=
 =?utf-8?B?Y1FicHFBWTJ6ZWpaL1dGNzlCSVJqdlZjRS90ZTZkdXF0dUUxNVVkdnVoZ1ZX?=
 =?utf-8?B?N2N3WXljbjVRVVQ0UXlsaXJudWNUVnU5bnk1bm0xL05CcktXUWFkbDRwcDBF?=
 =?utf-8?B?bjFjZExMMWNYTUFNT2RkQ013ZncvR0pNNGJTSkFGa1kxR3VURUFOSjFmeGlh?=
 =?utf-8?B?aXl5Y2tyc3VaK0N2YlVybC9mMnN4Y1Ivd21oZit2VXhKTFo1c1hiVW1YWVVa?=
 =?utf-8?B?VXZia0g2OU5lZFN6ZlJRTnZXeE9uSXY0eHA5dGZLRlZteHFiSWM3azB1NHRl?=
 =?utf-8?B?Si9kOSs2ZE9YQ2U3YmVnVWZQYS9LOW93RFdaRnFvVHZySE5vZWpubno1MG9w?=
 =?utf-8?B?RTVJL0FJcWxVRG1GNzcxVjRsN2RYVFVTQkpZVDZBb2RHR1V0UjFnR2hXMG45?=
 =?utf-8?B?Z0I0WUhYNFNCRktBSnZrdUFJL0ZDcDdyanlUekVIUTZ3TzVUVVdHMlArYm5p?=
 =?utf-8?B?TWJ3ejMzRHRUL1F6RzExaHdZOUM5ZjFSanhNUUxKOG9vQk45aGowTUtid3cy?=
 =?utf-8?B?OTU2M3EwY0ZnVEZGcGpRYk8rSDA4UzBiZlcxU2lpeXF3bFpLb3FQZmFBT0Vh?=
 =?utf-8?B?bUh2d0dsVGs0Q3RrUVZhcjdCOWNPSnZiTTEyaStMd0dobVpRQ1dIOXdaRWgr?=
 =?utf-8?B?RUZ2SjZoYVJuaFZqSFpPWi9pejlTdDV6azlKWVg1SHNNNXBDUkROKy80Yklr?=
 =?utf-8?B?L0tuSzF3Z0hSNmEvTGdvTU9sbThzcWhxMzNNYWdJREsxWWpQYjRCdS9aNTZk?=
 =?utf-8?B?OExzbUlyTnhudUdSbmtSS09yQjdleHVVQnBtYlJ2bWI2b0ZoUjUzdVY5d2gz?=
 =?utf-8?B?TTI2UXNHTWxMRU16TUxWSENWczZKTS9IZHBwckNNNW9IeDBGVEVYNEI2VXRL?=
 =?utf-8?B?d2NlOXh2dzFnZURqZStScVNidDdyQTNzL0VKeEFGZnlmNVVHc0VnaTFPeXVq?=
 =?utf-8?B?MjBTNnVlU3ErSEpYdi8zeVI3VHVQMFRuZERRK05pMGNTV3BYaE12MXZqYUxO?=
 =?utf-8?B?c1piSHZNazgwem9pRmhYcUtRdWkzV2dGM0hOd21HT2l0QjBMbHF2N2hYaDIy?=
 =?utf-8?B?WENjZ3VaNmRYb3p1QzJpNHJvcjZXYU94NVVmWHNDL3RjS1VQaHVEMWxGT3pZ?=
 =?utf-8?B?bTJIM2ZldmRwZE43TldMV0hLTnh6Umw0UEZiRmVGQXh5S3Z2VUc4akF0Q0ZF?=
 =?utf-8?B?Y0loOXNUR2RKS3Vnc1JjVTVzcUxvd2dJQUNxbkpic1RZVFVyckh4ZFlRYlli?=
 =?utf-8?B?dFBIRlNCMzh0SkF6clVpeDdoQTFpQ0Fva2NWdE1CWVdSbjVSeCt2aE1CQmFO?=
 =?utf-8?B?L2pPdTk5ZU91MXU3ZUVxdlVNYitQeCtNeFVRMXJseHFsQ243ODJaenNSc2N3?=
 =?utf-8?B?QmNkdEJCb3ExNGpFL1hvYmgxc09mUVFyN3dOZnpKVHl0UVF5TnY0OHVIOTh1?=
 =?utf-8?B?enp6WGMwL21MajJUL2JyLzZLTTF2SEdpSFg2d2FpTGt6R01zOVg2Vlc4VUVZ?=
 =?utf-8?B?aXBVWUVCMlJaOVJXVEJ5ZTU0SUEyUis4MlIxV0pybzc3R1E0ZG1RL3JYNC9E?=
 =?utf-8?B?MVdVcXNlQi9hTEp4WkpLallWb3RSTEh3Wld5M1hRdDZvWkc1TG9BLys5dG0z?=
 =?utf-8?B?dk9SWXBaWTFySjlUV1dDRmxPRGhXMWJ3TElkYjlDUzNOVGd3T21ybVEvM0dB?=
 =?utf-8?B?bmFHYk03RFFRUDNoeWRlL2FJZm1CRDlzTVNsK3F0SHdlNnlLSnEvSEJNU0Y5?=
 =?utf-8?B?dkppTGhTMW41UnN5U0MydWtyZW1UMm42amN0Y3dLWElQdk9NS0lNNTRqcDVm?=
 =?utf-8?B?YU56aVV1ZmZ3cjRNajZJWktROUI0cWNxY3kreDJSYy9LSytCM3VZNkZrRXlo?=
 =?utf-8?Q?Xz9lR4Zfcerg+copjOega33jO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SjIZE/SdCSBUP9GoQBrVfWVxfhK+7HHzIxIu9dvl+UCr70kH/MNdFBlLdlMoVyMdw1Bq32FvTIVk3bwhS+D2Eo/dfP4Og0sE9qTJ8CDqIgah9MwwkRVmRncp7mOVkzKwBUlsmjAEOpZU17rpGIb0zNviuL6WR5R4W/KBMHRT6fju637erGFuAUIqhxCs9/8L52H4dUK69rYAevCc+E1aIVv3XIKZWQQXmOLp8XqO4+S/YBbyPyi2vCjoRFbhLbU5KANQx1xgP9IN56IJEswkRsE7yu05L6v0jCwLSsAHlCfBNvzEYx4SLDhxMd+Lit14OsCBjVmE9Exp7yMKEQ9iUdgHaF4tChVfvgOoUAZ5O78PNRyUX0eYdnZmtSAucEdo0pC1MJd2IBWygFMpCx3cLgJmK874IU8c9fSva6j7FvFgayz2yFFMAL31U0mzbC0ADXcC8dGjvKrV4JC/UOGnFoFostsOEI1pczHm1MXoy530peAkxrWPP1upYymPFlE3C6HPzjO9vrRCPQ9rmTtC0sMTw66R5rTjpbLNqDzg07vvE7Kq88CD+PyNYmVzZfkeXexxKPZ95vJ8XS0sqWcq1QMqUVFCFx+87BmfMQixzrs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b6840c-c6ab-4dd0-9b51-08ddecb8d53d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7364.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 20:14:35.4386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wUVBUh0ccJikKAm1fn0PbiEjqrr+tllcPtTJDFx4e9S6wvXr/rg+fE8M0CesMwAdqdV0fGk5XYV0BAvBZjEFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_07,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509050199
X-Proofpoint-GUID: ou-Z6mCoGNJe2Dn4qFfM65MO6mplFjPW
X-Authority-Analysis: v=2.4 cv=e9cGSbp/ c=1 sm=1 tr=0 ts=68bb44b0 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=lmXTQecaTGsjHuktasQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDE4MCBTYWx0ZWRfXwK6+KXttPBZf
 dK6kEE0noXu9Aahpib0V1EGhV/411SCd2CneMkvXmu7a6NMHchRsnq4WAyV2pfGsERJVzynRkXq
 s3dOrnB3uLWST6nwyId1i99d5zNEfwZmOrU6uMAtLqMRd+BVG6wrnStJLfVywTgW0MGwVVh/vhV
 YCQJpnhsUjGZfkmbSi+6jW2fh/XWcAcSjDXSnBkstm5AdAqE6YrirEnZX74b518ps0GJaJkyMUU
 vivHn2+P5/7DlRWZxtRUJDAHFaBYIgfuup/J2pNJdsMY5cfzykZxrwPPlcnA+kbpFqarfxti6PO
 jdMr1xtalRtTOvI2Y/C05XFDQIs7ktloUJtb2VdkQDpupP0nNHti9DUJpeSvL0JNI4A2jxSPcml
 AQSitNwQ
X-Proofpoint-ORIG-GUID: ou-Z6mCoGNJe2Dn4qFfM65MO6mplFjPW


On 9/5/2025 12:58 PM, Luck, Tony wrote:
>> So the issue is the result of inaccurate MCA record about per rank CE
>> threshold being crossed. If OS offline the indicted page, it might be
>> signaled to offline another 4K page in the same rank upon access.
> 
> It appears that the BIOS that resulted in this report sensibly treats crossing
> the rank error threshold as needing a one-time report via GHES.
> 
>> Both MCA and offline-op are performance hitter, and as argued by this
>> patch, offline doesn't help except loosing a already corrected page.
>>
>> Here we choose to bypass hugetlb page simply because it's huge.  Is it
>> possible to argue that because the page is huge, it's less likely to get
>> another MCA on another page from the same rank?
> 
> If there really is a problem with the rank, it likely affects most pages (or
> at least most pages on the same NUMA node) because memory access
> is (usually) interleaved between channels, and accesses within a 4K page
> may hash to different ranks withing a channel.
> 
>> A while back this patch
>> 56374430c5dfc mm/memory-failure: userspace controls soft-offlining pages
>> has provided userspace control over whether to soft offline, could it be
>> a more preferable option?
> 
> Thanks for pointing that one out. I'll feed that back to the original reporter
> and see if it is an acceptable solution.
> 
>> I don't know, the patch itself is fine, it's the issue that it has
>> exposed that is more concerning.
> 
> Agreed. The root problem is the BIOS using this threshold reporting
> mechanism, without there being a way for the OS to determine the
> scope of memory affected by the threshold.
> 
> When this was originally implemented, the expectation was that the
> scope would be a 4K page.

Thanks!

BTW, forgot to ask another question.
	ghes_do_proc
	  bool sync = is_hest_sync_notify(ghes);
	  [..]
		queued = ghes_handle_memory_failure(gdata, sev, sync);
	  [..]
	  if (sync && !queued) {
	      force_sig(SIGBUS);
The question is, in the CE MCE case, 'sync' is never 'true' by design, 
correct?

thanks,
-jane


	
	


> 
> -Tony


