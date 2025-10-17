Return-Path: <linux-acpi+bounces-17883-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAECABEAFD3
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 19:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B2F7C2F59
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 17:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2122F1FCC;
	Fri, 17 Oct 2025 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="qS/yi5+7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022100.outbound.protection.outlook.com [40.107.200.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42C92F12BC;
	Fri, 17 Oct 2025 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720399; cv=fail; b=NzyRoDAwSPRhkCsIW++ot6y1KijSragepJhCLE01/zJ/821QBQp4RwJS8K71/xv8+z+NNktB2IXdQoKicrtMfxQ6gj6Rz5fkPQQ4sH69LPbTjXHf3QlEJl25EpdrOFu989o8X6Ph48EbxO7tE67Ck17UQ2hH1i+MX+i/drQR/II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720399; c=relaxed/simple;
	bh=8gj4mbhO+tNpW/RcvwTqFJpQgOPWMA5pMsXd+sKZ0LI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bWhC3cynrMtWEqbxnTlefcSdjcYxF7sf+v8sp6XwmJPbKJ9x9smUsU6DwAkHrXZF6e9MqKjidecyQR6eyHq80j8OBWBc/ryYYcboBgKgB9E56kZmXcuNwqEb7xiJJcMobgo7aqZmPstGUObu8a6EdvK2xcTulXxavnFZ+8TPsUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=qS/yi5+7 reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.200.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcTwNBuyB6kskv0kWPG1dbc5EGarItDJnaCAIk1RtjaFwATGI/gxjtIp5Bon8LrmWV6zkMoxUrwLXU+G7vFsvW0Y1AsR/yyoxxEhOPAVbC9MEzWj1U/zOrElwzjkZFxJ7eSZPBdgdZDtKLm37q/e65n8eI5oSeDpOVtwdXm2V0Gumsjmt5BwBBfQxygj8s+VD7NHxIGMrWq9lPXwHSSfM/Qu4xEd2D+DoiSlGx5PcYjiNp5qWpfEfiB2nnL+huvLY/BqKbgK7kS+qOapcF8GWMKDPcx7jxxF37mlOGU6xzSrvu8yTcXuUXCWuyIG887vWxpp7aHysjdelWMAPvfO1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktAE2W5iip87xomJ1yXpYxFBq16noZxh0jehGfJVJ28=;
 b=lWuZRPhhZqaoIiucl58bJsPPHREY0Rgz51A61zTo5iMwXwmQc2nq0FE+RVB7cnq05zcC1OQMuTZ/CnMwlIMCpZ2pbAU9e2FwTW3xRtXjUZn9XVIzqsPYAxHkUMG6bcqPH0M5yVpEBZBsOLNAO2mu4B2doNEb3aQxWzx+fFtJD+ui861v5VOq16xv/axmdEU5dXYeng3wWqVLDAXc/75vLfAE9qZFotP05qjcFv+cMTvp5E0+VhtI/rE4B0S3HprL1mX3DzTWoeK8nOp4Pp2NAoK5ZWEL9/BEEAmn+6Zvjld6vz8DdweWujVGUwsumsmcNzeRNfgAmbBlpmgJXaPajA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktAE2W5iip87xomJ1yXpYxFBq16noZxh0jehGfJVJ28=;
 b=qS/yi5+7Fk/97sZ1vZeMLVJx21tRhyv7iSXh/KUrdHZ1jhNJS38k5QPy/UUwllSGfhjCLnOsWFMHSkPb8gg3zZHhUJs26rQtSY9rgZ1eo+uY7AaY2mztfOZz9+JRCpH7NIBn0Vt6Xjc4AdZ4+8U4s1Qttlx/sZu9oIntUAV+rY4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 BN3PR01MB9209.prod.exchangelabs.com (2603:10b6:408:2ca::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.11; Fri, 17 Oct 2025 16:59:53 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9228.009; Fri, 17 Oct 2025
 16:59:53 +0000
Message-ID: <ffcaebef-9575-48ab-bf81-a570bb93e3c4@amperemail.onmicrosoft.com>
Date: Fri, 17 Oct 2025 12:59:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] mailbox: pcc: Initialize SHMEM before binding the
 channel with the client
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Adam Young <admiyo@os.amperecomputing.com>,
 Robbie King <robbiek@xsightlabs.com>, Huisong Li <lihuisong@huawei.com>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Cristian Marussi <cristian.marussi@arm.com>
References: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
 <20251016-pcc_mb_updates-v1-5-0fba69616f69@arm.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20251016-pcc_mb_updates-v1-5-0fba69616f69@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR19CA0106.namprd19.prod.outlook.com
 (2603:10b6:930:83::29) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|BN3PR01MB9209:EE_
X-MS-Office365-Filtering-Correlation-Id: ddd60a21-4dab-4423-0f53-08de0d9e97a8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VG1ZUWMzdFd0V1pvemV6dW1XamxFRDVwRzRBVUFGRzEzaWkvM1dFU2xUNEgr?=
 =?utf-8?B?RDFOeWMyQmdCYUlQNHEwQ01zNGJxN2lzTkYva2pxWWNGVG5aVm9zN3VZbFZ4?=
 =?utf-8?B?WWFzM1FpT0czUGNyaFV4M0g5SmFxWTFWbGtTbXlOdjZPTUl3N3U0dEgrVkxL?=
 =?utf-8?B?OXQ4cGZDZjUwY1laanVrM21HZUsvTExSWEc0MDFKc2Z2MnFtSFhTMkdqRk40?=
 =?utf-8?B?TGJodzZxMjIybU40RHYyT2lWbUJOS1BXZVdqMmRkeW9mb3NPQkRMcWRPeXl3?=
 =?utf-8?B?L3djczQ0ZThmQlVrV1hMSm1XTDZKMXBCbU14cWQ3N210SmtoL0o1S2kzRWdV?=
 =?utf-8?B?ZmZuZ1Naa1RGbzZtRW9xK0d4L0JuUFU4RVZlMjJQNmVOY3RQMFJ3ZXp1Zi9Z?=
 =?utf-8?B?cUcvZi9wZmtKTm5MZDFEQk96eTB1U2RnWENnSlNWeTFFalpoUW5lQjB1Z1N6?=
 =?utf-8?B?ZjNmZFI2T0x4ZzNpU1dBenlmUlpGcjdjNXVjWFNuSHgzaVRaSVlSdllMUzVT?=
 =?utf-8?B?NEJkWjAxNHhxU1BIN2NkRk9WWklKb2FWd1FIYWtHQjE4UkQ2b2c5emZadkNO?=
 =?utf-8?B?cm9XVjBMWlFuMTZEb2FuOFdrMHdyclgrT2hBb3Y2ZUU4NEZLTDc0a0JMUjNH?=
 =?utf-8?B?WTVNdVZTQkV2UjZlVnFqK0s3cnBDUzROQkFadzIxdGM4aHRsT09GTUtGcnNM?=
 =?utf-8?B?TW14bHhJQnJXNzZhUTJ5NTJHbFYzQ2FHRnd6ekQ0eEZ3RVFiZjdoRHNEUXpH?=
 =?utf-8?B?eFkxRWs5cXBqUXFYdi9qMzNrYU1iQ1hHVTU5RGNKMDRFempaUzBBeWJQRGtX?=
 =?utf-8?B?Tkh4M0Y3RThBakJ5OUh4MjB0dkNES1U3anJvU1BmOXl4ODRCbWNFL1ViRW9p?=
 =?utf-8?B?N0I5eXQwemEzK0NSUm4xVEt3MkFraFZnK2doVUpRcjFuTncxemFoUDl4c0hs?=
 =?utf-8?B?UkNTQUppR2kva2cxa0ovL2Z0R2FxV3BYbXpleXYyS3ZQSi9jWFAxMThXeEt3?=
 =?utf-8?B?dnZnSjBZQWxoWVBpdkRYVmRXdGswVXBzK2Y3cGlxOTNMTFRnM3EydFduaVF1?=
 =?utf-8?B?UTFNS2F1Mkpjbm1DblpjR3F6ZmNIWmx5aE96eVZuaXFqckswUGtUaUJlTDcw?=
 =?utf-8?B?ZWxCUVR0bXRrdVZwVUpJRWZUYWNBc3F6bUdPck5neVhrZ0ZtTUx3VE5yYTZr?=
 =?utf-8?B?cjk0QW9WNU8wYUJDdDBtQ1EwYWo1Y1lZTHVhbFNiMEpVNTgyckV2aVB1VWxx?=
 =?utf-8?B?Y0J5emttUHAzeGZhMkFrNmdWWFlKdFFPY05tRElmaWFvSDdBWnhKSjJqY1Fx?=
 =?utf-8?B?WWVnREVMUDhybTVEQmNSTjFNa2d2SEtCNDhaeHBhTndIYWx2OTk5SXcxblp3?=
 =?utf-8?B?cHIxdzdPeFJBc0ovd1ROYkFTdThsT2xET200Tjk2bkpYWmI4d1libFF2TUVU?=
 =?utf-8?B?VU9qOWxRcVlzcnZyNUVmRDI1cmdtR2lhcElMckRnR1QrYkpSV2YzSlErSm53?=
 =?utf-8?B?SE43TVBHS2ZIK2NzdlFrTGg4ZVAxL09CUkEwZVQxQUlHNW80Qm54b2cyVlB1?=
 =?utf-8?B?N3o0b0k4MTVIQ0tNRVRkMGdEblFub3c5ZGcxUjZDQ0h6bjZ5eHFwdVJublRi?=
 =?utf-8?B?dnFETTczV0VWbXVVZ01rZE1wMGRpaHRheTRnbXVqYTIxQm9Dems3eFpUUmM5?=
 =?utf-8?B?YXRPN1paU3FJVXZvLzh0TU50WTZUeTVkV3FES1VFSzQ1Rk56d0h2VS9qVG9m?=
 =?utf-8?B?YnJXNSs3RmFxYkFReFBtSzBJSTkzRmJMMmgvWFNZWklaRWNyVFUwZnROUFFL?=
 =?utf-8?B?U3U2a0QyTWc2OTN2QzZ1SkhLSUNKM1VNQW96cUh5bGk4dGl2U3JqL3BTcEhM?=
 =?utf-8?B?SlFsTEJrN0Jzc2pnY3RQdHFkZ3ZKV21QK2w3Ui9QRDRHcWN4VzBvN1Z4Q0pw?=
 =?utf-8?Q?1Vg4+qzqBT+04MUdRQ1Q/jADfHKTqbCF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHU1cFpDTUxXVmF4L2JYc0dVN0oxZWR5VUFNVStqQmxINjJZRXdyeXRzdTdY?=
 =?utf-8?B?UGU1M2thOTA1WUFWditNWGpScXcrcU5DNjZJcXhvL1g2THBSZXZLNk94ODVT?=
 =?utf-8?B?cHRFZXpuQktqSHFoNzk5OCtXOExlQmFZV0E3S2hUMXBYYU1Gdk1UOFBmaEJV?=
 =?utf-8?B?MXpkNjQrUnZXWG1maEkrVTREZXV4VXVieVNBTzhMcUVhYVlmS3VVTTZIYUl0?=
 =?utf-8?B?UkVscWVEV3VWVGx5bXhLV1pDa3BvTyttNXVvZW1OQVBNUk11Nm1mSzR6a09o?=
 =?utf-8?B?MFZjYlIxSHVqY0MvN215OWlQazhKNmVHR3UvdTc0SzJoRkMvK05UVTB5RWls?=
 =?utf-8?B?clNqcDdpcGo1M2lFaFZ0RXhld0R5SEtoQTRpaGduaUR2M21BU1dnbU1KWC9L?=
 =?utf-8?B?L1NySHlpakZVQkhSeUw5ZlNOSXZ0QzQ5c1krMVUzTGtnUjNlOGI3SVg5OCtK?=
 =?utf-8?B?WGFOc0NZanhFa2JEdjhTanVaWjR2L3FOTURjSmxpTE9JbWRwQlpIck04ck1m?=
 =?utf-8?B?MkQzczQrQmNrRUtFK3BIWXBYdnlnajlDWE9wNXBaYThxVTZ2Q2JNM1NBQWJr?=
 =?utf-8?B?bDFoY3BhY1AvQVVWY3ppUUE3TlowaCtQeU4xS243YlE2WnlROG55bk9sMWhU?=
 =?utf-8?B?aktBTFAxc1pHb2pMd0JUaUwzcGQxb1pqaDFaMnBRSVdJVUFadUxXMWxjeGRJ?=
 =?utf-8?B?alg2MmFHSE12WVgrcFJqLzNlSkgyK0V0TlpldkFRZVg3TnpMenBKcjNOeHQy?=
 =?utf-8?B?WkozdmN1dHo0WW4wQnhDNTlsalVuV0hxV0pqSUhhSmZnZEl5eG94VDB2NklI?=
 =?utf-8?B?amJBc1dBV2s4all5TkJZNDRYc3lESWhGbWNDMytkMkJxRm9MRmxTQTFZNDNH?=
 =?utf-8?B?WkxTNXJ3MnFUa0ZaTzRVUDZwUDNHUDVidVBQRFl0S2lzSWJlMXpPaXcwNUI2?=
 =?utf-8?B?RllKK21pNy9GbXBOSkdzYjBUSHJmRWhRSkh6RzcwUmx1TGZUYkZJdXZYQlZt?=
 =?utf-8?B?cVZLNFRFTk84OGdSVEs3b29wbmJHbXF4RTQ5VUp5eTZNYWx0TVFzY21nODZB?=
 =?utf-8?B?aCsxbVFIcHVrb05jVHVlendvTlc1cEJ4MDNyYlFyZzJzcFh4RW5RUVV1TmFP?=
 =?utf-8?B?TXJjdXRZa1dCbXVJcXZ0WDVmWWVvTFZvbGg4ckNNUWJ5Q0FUbnVwaE05NjlW?=
 =?utf-8?B?b1d2ZmRIdjhoNHRNdFVzV2NmdlZCendQaUhnQ1FhTUtEaTRXRmc1UXhXLzFp?=
 =?utf-8?B?SlpGb2htanJ5cWhjMmJJVHFFZk5UWkpZdW5JOC9kSGlNM1dBWCtSdkV4eVhQ?=
 =?utf-8?B?VEFaVzhsL3Rtb2ZEaHNLVllpci9YQjdYYTlaYkxLcmZMUGJpV05sMytUNnpu?=
 =?utf-8?B?dkxOcGIvcktEYm5Lb3pTdnFxem45VXpTL0pkQVcrMGR3Z0hYRVRzSHRndTdE?=
 =?utf-8?B?K2cwMDRGT3dEMzIyUUZpaGowWHNaRGNaMU85Y3R0a2tNckltMk5wVzN6NnM3?=
 =?utf-8?B?b0VyYk5qc3pSMXJZWXpjUjNQYnI0OFAvbC9GU2Mycml1eExZdzJXK0Z0ZWtn?=
 =?utf-8?B?RnBQZit4blllM2o4TWNIdHJ3ZkZXUHQ1a3VLTG9INytrV1lTS0gyaVVUNkNZ?=
 =?utf-8?B?d1NzbE1ReFZtT3B1Y0crbEtudWNtL3pTY2txYkx6blk3aDFvWGtTTStURDNM?=
 =?utf-8?B?eWhLOWxiTVdZWG9LSWk0ZnJhZmZoZGJlYkhJa0pUODEwRVNmMjZ4a1FUejNR?=
 =?utf-8?B?NXlVSk43NmsvVHFYU1VVbUJ1SG5pSkNCSHNla01nNElNYk4yblpMNTExQXNo?=
 =?utf-8?B?dUp0dDRQYXBrZGwyTTdBTy96eEF1QlFNelppVWNKTEg2S1ZSV0crS0ZDMVdO?=
 =?utf-8?B?bnNHYURFQ2g1Si84Rk0vT01mOTdHc0lRRStNVS9nMUtlOVk5TjJJOHNuMmdz?=
 =?utf-8?B?N2ZsTHVMTGR3cDFxeUNzbmVnYklXZzl2YWtic0JhVEI2V0prYm93N1VKTUlS?=
 =?utf-8?B?ejVjTSs2a0UyVGM3RFVaMzdGTW8vNUg0bTQrTWxSRHl1Yy9nL2xiYjFibDdm?=
 =?utf-8?B?WjBid3JESGgxMzNNam1Qd1ovUlAveDg3VVg2THVGYmJURk1KMXFveGxoV0ZG?=
 =?utf-8?B?QlU2THd4U3hGR0tVR21qcDBBY0FDMVRhL3IreFdpdi8wMERqa05CUXlEMW9M?=
 =?utf-8?B?bzZFZWkyVXptUWVUNGp5ejRrZ09NRVd4Y0tIUjBtRi9CeWJsZ2hsZndjNXRk?=
 =?utf-8?Q?5L8ZL8UetnDSVmt2aEB0QTkUs1etLFacAxJQtsU1Cw=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd60a21-4dab-4423-0f53-08de0d9e97a8
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:59:53.4754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scoXSSf7HIil9YG5b3wc2tlrXt4cr+7R3/PoM7asriQxQwOzIkIt6S4pGVvnB/Ad/52jOVBCtqCLVjCf7xsr2KZcsLqocaqIEnagLqK1hsyCr+BXZ7Bqy/57j+YREIw9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR01MB9209

Tested-by: Adam Young <admiyo@os.amperecomputing.com>

On 10/16/25 15:08, Sudeep Holla wrote:
> The PCC channel's shared memory region must be set up before the
> mailbox controller binds the channel with the client, as the binding
> process may trigger client operations like startup() that may rely on
> SHMEM being initialized.
>
> Reorder the setup sequence to ensure the shared memory is ready before
> binding. Initialize and map the PCC shared memory (SHMEM) prior to
> calling mbox_bind_client() so that clients never observe an uninitialized
> or NULL SHMEM during bind-time callbacks or early use in startup().
>
> This makes the PCC mailbox channel bring-up order consistent and
> eliminates a race between SHMEM setup and client binding.
>
> This will be needed in channel startup to clear/acknowledge any pending
> interrupts before enabling them.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/mailbox/pcc.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 33bd2d05704b..2829ec51b47f 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -378,18 +378,20 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>   		return ERR_PTR(-EBUSY);
>   	}
>   
> -	rc = mbox_bind_client(chan, cl);
> -	if (rc)
> -		return ERR_PTR(rc);
> -
>   	pcc_mchan = &pchan->chan;
>   	pcc_mchan->shmem = acpi_os_ioremap(pcc_mchan->shmem_base_addr,
>   					   pcc_mchan->shmem_size);
> -	if (pcc_mchan->shmem)
> -		return pcc_mchan;
> +	if (!pcc_mchan->shmem)
> +		return ERR_PTR(-ENXIO);
>   
> -	mbox_free_channel(chan);
> -	return ERR_PTR(-ENXIO);
> +	rc = mbox_bind_client(chan, cl);
> +	if (rc) {
> +		iounmap(pcc_mchan->shmem);
> +		pcc_mchan->shmem = NULL;
> +		return ERR_PTR(rc);
> +	}
> +
> +	return pcc_mchan;
>   }
>   EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
>   
>

