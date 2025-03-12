Return-Path: <linux-acpi+bounces-12152-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C13A5E75C
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 23:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ED6C7A45B1
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 22:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603FC1EFFB5;
	Wed, 12 Mar 2025 22:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="1u2Qk5B4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023129.outbound.protection.outlook.com [52.101.44.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995781EFFAD;
	Wed, 12 Mar 2025 22:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818363; cv=fail; b=YDMEzORWkHG8kJs52CXydiHtrjf0mklq4BWBVIQgkdkSn11AWGsbYx48e9cbqS9eKAkPiR+mNgs0vbNzs+QUUaCmHmynseZlvMGETLExqKZNnFrM3BdnVYI1KGSsxY0TxZxTqBJgm25jOHm3OobXwdkqUQNdvTNVB9D1v8+Etko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818363; c=relaxed/simple;
	bh=wvdrKI/zodBaz4bTUHozr4wWyLfFYs0+aSvMGWbk5SY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GdrxRskUFHzDNTnXXX/WD4rengmb0swVI2LdGscYGzTHSF15NViec5WPbQzHsKkZk6zVa7t7dKW+A+PFPgzDRoEWMLk0xchx1CTUcgIaUz2Lu9Yt+Lfr440tqz7p9nyp5/kwtcOju8KOWqfq4LSaQJiQZbT/i/17BL4bglEaDgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=1u2Qk5B4 reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.44.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVbxAiZJ44lx6a3Yi8iVQDhThGbXwiW1iu6KBcLF3XmK1C7R2Hp2WJ29VltkzPVfTv41QdQtzqubvKQOaHCyIqxc6UlqQGtDVLJ+TQYzlfE7Y4aWw0UTjn8SGpqIvjFNZ6aM7L6oN6E4I3+We0oDnNA5TDdb250IeES/cLEkp+2f32REZOZLsI1532HTvr11w4acEtQGrJd9KackrbbeY06NaAVOKBYm6yVYDNUIoF3OJ1PpHI7TAVC3tWRtcjQ/Gg18aKHUKC9EXMkhaLLG9F7+XYhS0Iymb8dREeXClu0XyIIO2rRpiOXFF1Tur8cAWDyhv8iBVlaGTgky9fHYPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7wON2/92qFO8tGl/yZx0/l+qTcpgnHanIymKXYl9Yw=;
 b=SyWKbIJsC0noT1ukgu4fdc+xR6F8XGI9c1/x8lUu5D/6iCJ/ryHD8fg0XNN8INZjpOgbaIVzerRDVQG/bKgAASrBZMA06xofqNpyKtW5dDlXbD+pI+ATm5yEyZakqYfXWUMNgVF6PTysBOtiJbjHrQ1qFsuIO5tEmffVMLSDaKRjhkMbj3fI30B2UCX6A4WK+n3oTKZKfc8q2I+pdEEt1xwTrGCYnIN32X/3oyn2X82lBpRiQ2Ifjlp1MSaofCue6ficA+wodBp1mu//3SJGchHxUf1V2wsFCyeAxcpOqLCddwVrI811tvFb1o9UKUbu/Y5XR6UvfATfJNj2s6ZNhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7wON2/92qFO8tGl/yZx0/l+qTcpgnHanIymKXYl9Yw=;
 b=1u2Qk5B4NQZ0Rsqm52tjkwLKmiy8TNFdqsw/ZX1SJubPlBq3da/pv95mBcPZkBPjdDHHJU9PxWPUHpXrnnMLsRVUcJDYmKulV9Lf7WoUg88ofyXxlTGOvjrVrkfZ2IbEU7nAWG+haM28MB+K5E6W56hZpqBEyCsFr2Jm1CPGZb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 BY3PR01MB6788.prod.exchangelabs.com (2603:10b6:a03:360::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Wed, 12 Mar 2025 22:25:59 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 22:25:59 +0000
Message-ID: <fc5472ee-cc78-4531-b4df-dc7b621fd222@amperemail.onmicrosoft.com>
Date: Wed, 12 Mar 2025 18:25:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] mailbox: pcc: Always clear the platform ack
 interrupt first
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>,
 Adam Young <admiyo@os.amperecomputing.com>,
 Robbie King <robbiek@xsightlabs.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
 <20250305-pcc_fixes_updates-v2-2-1b1822bc8746@arm.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20250305-pcc_fixes_updates-v2-2-1b1822bc8746@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:a03:217::18) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|BY3PR01MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff8bc4d-402e-420d-e3dd-08dd61b4dd94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWJGNFVUZTNLUHdzTzhGQ0ZPUFJ3NG9oRTdLUmhxOVc1VFBsaUdSUkZmYW1H?=
 =?utf-8?B?NlFTUkE4cU9NRER5dTN3SUJNVnQ0MGJOY2R5UDlDRU93ZkZkQkxXeFFQbjE0?=
 =?utf-8?B?L0FBV1lqemVncHJnY1lXTkJKekd1OWFzMmZRUE42Qi9jbEN3NEZMQzFhR00r?=
 =?utf-8?B?OEVSYWZteWZXdkNBem53dTBZQ2pwbWFJNHduSERMbzVZa3dGQVRhaTY1b3Rr?=
 =?utf-8?B?WGZrWTUvbk45YjVwOW1PVjFJOXh6UlJvSHNrcXQvbTNhTU85Q3pEaE5RVGlW?=
 =?utf-8?B?akRvWk9iQjNrNk1JSURHWU5ubVZiSXBxbzVVOURhUUFXTTRROVBHdWo2dlhL?=
 =?utf-8?B?SWRzU1NpMVE5Mi9ldDhYKzVCZ2RMTUFtZkhCdDdEWHkvQTVzUU55TTBCZXJy?=
 =?utf-8?B?YjgxSVlFYys5Z3ZkUkxCUVZRbWljelBVbFcrWXc1SGRVQW4xZmdoTHkwOHNG?=
 =?utf-8?B?Ym1CQVFkMCtJT1R0Ti92MHJHSjZVeUJGb293MHpFYzBXeUFVdTcrVERZdjNU?=
 =?utf-8?B?WCsxcDRIbmNlelNRdEorVG5KcExoSTl0NGpVd0Y2cjRPWTVkQVhlc3hCQjhR?=
 =?utf-8?B?YW0wYXVTaWhqL2lCRVhpaWFIWmwwMkpEbmhsKzE5djRZRzR5NVlRUGx0OHRS?=
 =?utf-8?B?UFpHN1huOFNDUzBjZEU0eFVaZGg4MmVWdTdjd24rN2R2MkN2QUpod21Xam5j?=
 =?utf-8?B?ayt0SHJkaUhJeTE1TUxxS1lySEhJQnlkc3oxMXdsTlJFR0pCYTBSYmI4blU4?=
 =?utf-8?B?NmFuSWJvWDliTHJiYjZrQTRhTG0zRGtQK2h0amYvR0xkcFpGRk52WWh3TTU4?=
 =?utf-8?B?RXlxNE1TcnJuY3Ruc29BcjYxeU96c0s2a0JUZThibUJYNEkrWUVzN3dDVlJl?=
 =?utf-8?B?clpibzNoVEZINUpHd0Q1amczSHhUUTd5OUg4S0M3aUNpVk16RjhvQ203Wm5L?=
 =?utf-8?B?R25SZ0dnVDlId2FFSkowSEttekpoRHFCa3R5SGJGcThoMENwS2xEVDNwZjdw?=
 =?utf-8?B?RENNbXhyRFllSG13UXNXeWNybzhlN2Jhd0k2Y0VZZENjSU82WnhPdC8xQWEy?=
 =?utf-8?B?LzBxMUZicWo4RGRwSEZ0Z1hGQWQ2R21VRkdTSlFWcHl2ZElrbzhCWEhVSjFH?=
 =?utf-8?B?bS93RVBWRlBDSW4rRUpxdzNLQ3l1eFFjMGMyZlFPMWY2aWtIUTRsUS9ySk92?=
 =?utf-8?B?VUI2TVB2VzhPbWlMQ3huY0pQRm52R2IrL3pkZ1NvYkNTckpEd0ltNmFvK0F4?=
 =?utf-8?B?Nkx2bDNBL2I5WHAxc2crMXF1aTgzTVBSUlNrWTFOZW9xT3BvRkVhd3E5czR4?=
 =?utf-8?B?ODF0OFFVSG5sVUlva2pNM3R1OGFEdjBYcHhwa1ZjdjJtVkFwS3Q1TUlBTW9j?=
 =?utf-8?B?RmppOVR5NEYxblJ0bk93Q00vUTNzSXFSSDlkRS9lM1J4SGxSTVlPTUY0S3Qx?=
 =?utf-8?B?QVQ4cXVZYXBEWmZXL2RIbEo3ak5oZEh6VWxKcW12TnJNa1hyaFpoajlTcHpR?=
 =?utf-8?B?VHAyTWpHb2JEN3VHR0ZlWGpNTXpQekQ5ellsRUNnYitoZlFUQllkNDRkMWNW?=
 =?utf-8?B?UnpYTGtpa2M2UTJrdWx2UnI5SndFTWNOT2ZvTExHTTNWcVFvcGxmZmpnTjNT?=
 =?utf-8?B?dEpET0o5bERkdm81MjJxSFpYdFdzeWhZRUxReTBqRDQrYXBMT0dlc0dEek9Z?=
 =?utf-8?B?S3FoU3JQcnRZY1VwYWhmRWQrN1ZTcnZDZnp5NzFvQ0ExZ080TXlPd0JvSVpE?=
 =?utf-8?B?SDlQa3RmTTVuNzhXOEN4eDBzc0d4N3ZsbTlrSEFVTk1vV3FpbWdHSEljOWpE?=
 =?utf-8?B?cDFMY05LWHZndFhaLzl5aHhRZXlpNEFRNkJYUklDVnlxQjYvbVo3R2Y0ank1?=
 =?utf-8?Q?MmIXiQUrj1vzx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnFGT05jd0g5dW5ySGMyS1Aydy8wa0xUZjd4K3RiV2dWSEtsOEtkR1NhblFF?=
 =?utf-8?B?TmhxVXg3U2pHSzNZN1RZQ1MzY1krT000eGtBSUFHQ0lnMSswMDBYcVoyakt1?=
 =?utf-8?B?MzIvejhPSTJOVzdnWGFrN0FMZEhIdzhhN0liejB0Y0xlaTlodi90L2pQOTZJ?=
 =?utf-8?B?U1N1QlJ1dnNyOUJzSmFndzdjNEZLdlFvekp3SE5VYTNVbk1RUDBXRTlTTG54?=
 =?utf-8?B?aklMSDJCangvTktYMkdna1AzT3F3SUIyVlRYSTJiaVZBakpBcXRsRzlnY0R6?=
 =?utf-8?B?eTFEY2xZL0FHU1VTQ05XYTZCS0MrekRpaDY4Y1BMTUg4YTJJczlyTDBxZGRs?=
 =?utf-8?B?ZVdTYnJkMGRyRkxlWkxUUGVicSs3Y3RXQXdiWnV0ZnZZSEVxZS8vN0xkSFgx?=
 =?utf-8?B?UlNuTkVobXRmdUJVc09oY1FXRmUrM3dWWXIzMkxBT2Ric1Bta2grTUd0MTEw?=
 =?utf-8?B?UHhsR0wrVUw5MFROZEg1ZUVJTnJBclovY3h6UDdxeTdrRFlsMnRwR2RKZTI1?=
 =?utf-8?B?clNydTdiQnUvWFBHeDExZ29ITyttV3FHR2EzWkpFdS95N3NFZ1lhckUvYkc1?=
 =?utf-8?B?WjVlK3lNNmJ5MTE3U1JVcFNLN1Y2TlBtQmJiaEpmanhsdStpVnRJQnNaVjB1?=
 =?utf-8?B?YldWQUtEVkpBSjRMNDRCWVBkQXpVUGhhL3E1L1JjNnZKcGQxVjhQcXZuSE5J?=
 =?utf-8?B?SkthMTVyZEo2cDVYTjZXcGdtcWN6dXJ1R1dTdk40cXRwNWRoK2MrM3psN2FR?=
 =?utf-8?B?NjRYVElCdnhRSnlNdDdhcWljL1BwcGpJRzZqZTBQNUVhSGVVNjZMdVJDSW1Y?=
 =?utf-8?B?WHVHeVowUDRkRTN4MTJZRGFPdTRuUTVJZnhXNGhqUUxyT0x1SnR6S3JHY2tU?=
 =?utf-8?B?a1dUcU1zNFBRRklqYWxPU3NLT1lZVTdIMUJDT1pCK2lBbDhxVThaYXQ5b05o?=
 =?utf-8?B?cmQyTlJZMXA4NlV4ak5VOGZaWU0ybzZObmd3REpVYllRNjZzSU1mM3Fzc3Rk?=
 =?utf-8?B?dnhwcFJHZ2g2SjNqcW9PMVFsZ0o2Qyt3K2xhTGtiRXRibDlNSEEwM2pwSFNM?=
 =?utf-8?B?eHR6dFhSS0NDRFZ2RDFJalFvei8xcGk4aXB6d0JxcXZLMjBiMk5QYk9QYmtp?=
 =?utf-8?B?bVdqZlhCOUMvaUNqc3k0UCtWQytsUkZzSHdickhxdFhPMktOcS9FZnNRek42?=
 =?utf-8?B?RHBxc3B6TDBURDQ5OHpCZTlieTVKRmJydWxZaENyNVdFUmRXSEVsYmFndmhF?=
 =?utf-8?B?R0dtRWhBQmtsU2xmQktLcjNUK2U5UGg1NG9qbkRzSC8zbzRVbU53cnVVczVL?=
 =?utf-8?B?dFhJVXRvL2dyb2ZSVVNvVVhGV0FDd0plSjhzVVMwa2hDM25FSW5Vcy9tUEVo?=
 =?utf-8?B?SUhaT1JNZDJPcXJxVGZkUGx6QkRFekxQUFZLSkhxK3praHAwaGd1VEhaSDh2?=
 =?utf-8?B?QWtSSzNrRktJdU0wL0kydmNpTUpONWpudy9NSHRXQk52R3phWU0yRnI0bTJ3?=
 =?utf-8?B?T3pLaTRXSmlic09LYUFsdXAwMHJwbEtpWk5Bb1RHRlJaeThnOW8xN0JicVRi?=
 =?utf-8?B?MnIzS0p3MisvUnRqLzRxZFJXTWtsRUtrYUVFUFNSQ3o1OWVYTG5iZEk5b04w?=
 =?utf-8?B?TmZ4VXRpSXhtRk10UjVXS2VaUWlSenRwYi9ZVnhrd25QcDJOZVFzMVV3Y3RW?=
 =?utf-8?B?MnBzK3hiN2hSOUl3a0RDNGlhWmlLYjkxWi9MMGZmdngxZThHWWphMnQxUVZN?=
 =?utf-8?B?TjBnWFJJdkZvMEZWM3NkRWZiMXFmbXl4YVpEU0IvNXF3T3dmRzNNaTVuR3d0?=
 =?utf-8?B?ZGtZeEdsN0JXNjJsdXdCeFFIWXJHZ0pTN2xCc0IvUWRZZjVUN1VvV2Q5K3p3?=
 =?utf-8?B?WEcxYkhoL1ZjUGxMU3FJN2dPUTBNWm5mZTh5M2o1NWdSTG1pZmFnS1ZCZEdX?=
 =?utf-8?B?NloxOFpKd0NsY0FDVTFEcnhwemwzNTFPM21pNk4yK0pRYnpia000dzd1Y2pl?=
 =?utf-8?B?QlorSHZFcEFnTjg0ZTFvQWh1M002dXFZMUFISUxrRk90YW9ydFlFNEQ0bFo1?=
 =?utf-8?B?YWxLbFJDYXN6RE91eE9RcHZucVN4ZU80M1lydFhKWkVMSy9TRVZpMHc5N2d2?=
 =?utf-8?B?aDJMZ25zWHJHdUt0Z2NkeVpKRk1vNHE5bkhaTXZTc1BEcEFJa01qVmtGaUVl?=
 =?utf-8?B?Y203TWo3MGJ5Mzl5dFNuOGVrMmRHdmtKYWxVamg3cDQwSldaZi8vTjZNNFpF?=
 =?utf-8?Q?Ccfi5UFzhz+Yd4L1Ahyx2W80AkU+GM/ECZ5Jh+aMPA=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff8bc4d-402e-420d-e3dd-08dd61b4dd94
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 22:25:59.6744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msK6aRixGBVU1Co3RyRvsMQEkuBMRgYL/tzGAl+R03RtoOLxALf4aVooZWvnMOq8QkMM7DYdbskYT24ceJ9R/diiz6BWpWf6pYMDv/sDx1F9Q5Eif8fYdPdX86JMpthb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6788


On 3/5/25 11:38, Sudeep Holla wrote:
> The PCC mailbox interrupt handler (pcc_mbox_irq()) currently checks
> for command completion flags and any error status before clearing the
> interrupt.
>
> The below sequence highlights an issue in the handling of PCC mailbox
> interrupts, specifically when dealing with doorbell notifications and
> acknowledgment between the OSPM and the platform where type3 and type4
> channels are sharing the interrupt.
>
> -------------------------------------------------------------------------
> | T |       Platform Firmware         |    OSPM/Linux PCC driver        |
> |---|---------------------------------|---------------------------------|
> | 1 |                                 | Build message in shmem          |
> | 2 |                                 | Ring Type3 chan doorbell        |
> | 3 | Receives the doorbell interrupt |                                 |
> | 4 | Process the message from OSPM   |                                 |
> | 5 | Build response for the message  |                                 |
> | 6 | Ring Platform ACK interrupt on  |                                 |
> |   |  Type3 chan to OSPM             | Received the interrupt          |
> | 7 | Build Notification in Type4 Chan|                                 |
> | 8 |                                 | Start processing interrupt in   |
> |   |                                 |  pcc_mbox_irq() handler         |
> | 9 |                                 | Enter PCC handler for Type4 chan|
> |10 |                                 | Check command complete cleared  |
> |11 |                                 | Read the notification           |
> |12 |                                 | Clear Platform ACK interrupt    |
> |   | No effect from the previous step yet as the Platform ACK          |
> |   |  interrupt has not yet been triggered for this channel            |
> |13 | Ring Platform ACK interrupt on  |                                 |
> |   | Type4 chan to OSPM              |                                 |
> |14 |                                 | Enter PCC handler for Type3 chan|
> |15 |                                 | Command complete is set.        |
> |16 |                                 | Read the response.              |
> |17 |                                 | Clear Platform ACK interrupt    |
> |18 |                                 | Leave PCC handler for Type3     |
> |19 |                                 | Leave pcc_mbox_irq() handler    |
> |20 |                                 | Re-enter pcc_mbox_irq() handler |
> |21 |                                 | Enter PCC handler for Type4 chan|
> |22 |                                 | Leave PCC handler for Type4 chan|
> |23 |                                 | Enter PCC handler for Type3 chan|
> |24 |                                 | Leave PCC handler for Type3 chan|
> |25 |                                 | Leave pcc_mbox_irq() handler    |
> -------------------------------------------------------------------------
>
> The key issue occurs when OSPM tries to acknowledge platform ack
> interrupt for a notification which is ready to be read and processed
> but the interrupt itself is not yet triggered by the platform.
>
> This ineffective acknowledgment leads to an issue later in time where
> the interrupt remains pending as we exit the interrupt handler without
> clearing the platform ack interrupt as there is no pending response or
> notification. The interrupt acknowledgment order is incorrect.
>
> To resolve this issue, the platform acknowledgment interrupt should
> always be cleared before processing the interrupt for any notifications
> or response.
>
> Reported-by: Robbie King <robbiek@xsightlabs.com>
> Reviewed-by: Huisong Li <lihuisong@huawei.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/mailbox/pcc.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index f2e4087281c70eeb5b9b33371596613a371dff4f..4c582fa2b8bf4c9a9368dba8220f567555dba963 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -313,6 +313,10 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   	int ret;
>   
>   	pchan = chan->con_priv;
> +
> +	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
> +		return IRQ_NONE;
> +
>   	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE &&
>   	    !pchan->chan_in_use)
>   		return IRQ_NONE;
> @@ -330,9 +334,6 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   		return IRQ_NONE;
>   	}
>   
> -	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
> -		return IRQ_NONE;
> -
>   	/*
>   	 * Clear this flag immediately after updating interrupt ack register
>   	 * to avoid possible race in updatation of the flag from
>

tested-by: admiyo@os.amperecomputing.com


