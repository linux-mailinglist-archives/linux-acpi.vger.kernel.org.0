Return-Path: <linux-acpi+bounces-20510-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAImE4zycWmvZwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20510-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 10:49:00 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FD264C8A
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 10:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F237509E3A
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 09:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC5434F250;
	Thu, 22 Jan 2026 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LSRbL0Ye";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NlzNmB23"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A20D34165B;
	Thu, 22 Jan 2026 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769074981; cv=fail; b=HYCxa3NdrpqyLzApEMUafm4P2pNKEXcyyG95pT9b2yzcGVGqfNyWbrv+0VKtx5ZwrvvXL6JJubTgCfrq1s6RTAlWu+LoBiwKfuYPy9mycQmqr8/FbjT5D0wyg/EVmO1amVpdSspD1Rxt2j4JCz4/TwgU5gjKUyD8VE1XsJ1xSN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769074981; c=relaxed/simple;
	bh=1plWyS2/IQZ8G8iumg6xjfVfx9KGwe03axQfwhOfMhA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=at5SsLG1UaabsNOb8A8QaiFur2IYdoSUREPpuHva4p7I0+slVk6HtGuWkeB3LHFCNjNygVjOto9vfyrh+FwDiKNsIaVqaHkoqPIjwQoMndndp8LPBjfOjpi2Eofp7Oqs9eOoZzM8tm62ZdKhifbsDDCdpVICPiCQjy8BYYcOGdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LSRbL0Ye; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NlzNmB23; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M8dIvr421477;
	Thu, 22 Jan 2026 09:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1plWyS2/IQZ8G8iumg6xjfVfx9KGwe03axQfwhOfMhA=; b=
	LSRbL0YeNqZxkAqDzut/paCnCqVYlvwCmXrRXuqbyX93xtzY+Nv1UQXDgMGJI+yk
	rJle7ex47ssy28miwGLZ80tRxXQn8zf4ixmcpJMUoDivfolfnr3C+SI+M7xo1y+H
	IQdD9SKKWzZ2qqqPMGFtp99ddZEXgVsPHVLDEJVK8lXdI+AA8hKtu5SLQUKKhRjI
	QpLr/s4AfwLYSkWDKgqgCO8DpLnBY+8IvI10bRHVpBh/1BImmk9WGtFAH+Er5DP7
	ex1JjE3TIacZASADs3ugtvVDvqtR/9Y6iCwGAdL0Qs5FsOuVAjB2WTxVeBLMTNpM
	5mGD+7FB9VGKCd1kYbxmzg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4btagcv0bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 09:42:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60M90GCq018066;
	Thu, 22 Jan 2026 09:42:54 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010039.outbound.protection.outlook.com [40.93.198.39])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vcknxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 09:42:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSAOKg0GrJ30k6pNdIIVMJroHNDa6vXqf750efPMlE1SfDERFPUezqJ0kTUxBXdo4IcfbrrTBZG3T4uo6fVyp/SoMU63lS6HGOqCnAZEXJdPzOwPvfOtC2U8hEs1pm93CjmHVbpYuT4Tgwvjo95sqOZojAC1WjG/1WyPPHXk7KouF79FvHAxqaWz6+AxLz3pTfF1wNRRguOenLkRtXF1+TjwQRczaY83HCO2+VEPuPIQ/RONlsjdR7CdkWdeQijPcUyThbuz5Gc+l4i4h/bsQV0+Cw1KBlBZkkEX49CHxxJIAcezeDmBZBuLGM6LdU4rIq6M/M5WZR6scI23hb0aQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1plWyS2/IQZ8G8iumg6xjfVfx9KGwe03axQfwhOfMhA=;
 b=ZugqHdWVD2RxpLCOb+s8ehFJGo3Y84q3FH+YuStlxy96+cUystSGI4x1rltB64EcuzCo5JJE0LkN/284Y2n2gZ4Hlir1ra8ByqJ/Tux9ZtbLiKNHWLRwvWWCZVXxggVwYBE/445dHbP2NKk3OjAETB5rp4WuUHPJ5OvV9GOlFd0qgg+GyA6UWtasjM35E3h+j6JOhqdryK/Ow7yg/h5CoVVI+wC7mqK5mAQbv37Hg4wOnFWBC2MdLOagMHgCxXpFyDJKRInCHXvQs7tsTAYTw36QL1HCGvXyw5gdDSbG7fG4Hmm5gsPteHyje7FCNetUX8pBo+U2sjiS4xFOIWva4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1plWyS2/IQZ8G8iumg6xjfVfx9KGwe03axQfwhOfMhA=;
 b=NlzNmB23/wifstI/H+l0Kge5yfSo0npIl9BoWSg4Hxqb2jxTVBOs2+dmdL3AF1no0UrCfK0TibL5JCz/I0M7k9Gfjdr+NxF5V3bGeluaRA8H9u0RULupTq48cOxRiZ4uEWQUaPL0IAJV6/GuDgwZ88dQP5o0mJItXq/usUTRy44=
Received: from IA0PR10MB6843.namprd10.prod.outlook.com (2603:10b6:208:435::7)
 by IA0PR10MB7183.namprd10.prod.outlook.com (2603:10b6:208:401::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 09:42:47 +0000
Received: from IA0PR10MB6843.namprd10.prod.outlook.com
 ([fe80::ab87:4491:438b:c15]) by IA0PR10MB6843.namprd10.prod.outlook.com
 ([fe80::ab87:4491:438b:c15%7]) with mapi id 15.20.9542.010; Thu, 22 Jan 2026
 09:42:47 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Johannes Thumshirn
	<morbidrsa@gmail.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] PCI: Initialize RCB from pci_configure_device
Thread-Topic: [PATCH v2 1/2] PCI: Initialize RCB from pci_configure_device
Thread-Index: AQHcisoZzKcoj8C3rUu16aNbYxRdzrVdODgAgAC5FAA=
Date: Thu, 22 Jan 2026 09:42:46 +0000
Message-ID: <2C6ECE99-B9CD-4325-87D2-A2E212BDBDA3@oracle.com>
References: <20260121224010.GA1217051@bhelgaas>
In-Reply-To: <20260121224010.GA1217051@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR10MB6843:EE_|IA0PR10MB7183:EE_
x-ms-office365-filtering-correlation-id: 405b73d2-bf46-4aaf-ac82-08de599a999b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NENLeHFNVkQ0QnA5TG5lR1lCWm9aMldWQ1cwQ2I1cUlWSjJRTSsvK0Z4OEsx?=
 =?utf-8?B?R2pScGFoZk9LZDhoUnlwbnFZcjljRVU1K3pRMjJDbk1jNmJ4UVluOWU0cHIv?=
 =?utf-8?B?VTJmV3doOHNRQ1Z4ZmZaM0llcm9NTzM4YjlhWEYxaG9JTzJwQjF6NmdKSzdX?=
 =?utf-8?B?OSs2U0ptZFhBY3lRS0lwMVo2SmtXYWFEMVlwbUVCL2ZSZkZiVjVxQUp1Uk5E?=
 =?utf-8?B?L1JieDRtZUt0UVRJYm9UT3ZuN2JvMU52MllPZVdEWkNoY0xmVXVkVmREVm4y?=
 =?utf-8?B?WUpEU1pLWlB0YU40RFMrTlNZREVLNXhkblI3R29HYjkrTHd2SEI1RXNXWkRQ?=
 =?utf-8?B?V2dHQXgzWnVCVWVLUUlCQ0d4YkZha1FWaUxmVExiekR6SHNweWRheEUxNEgv?=
 =?utf-8?B?elZxQ2pwUm14UVpDNnJ1WTJVemM1c2ZWNU8xdy9UMHkySjNFZXErOUgrQnhJ?=
 =?utf-8?B?OHh5VVZTaW05Tk5jOEFPclBNakN0dzNaODJUZG1kK2JWa3oyY05PTHRJWUdZ?=
 =?utf-8?B?Z2N5Y3l4UGVENlFYS0k1RW9Edy8rV0JtK3RsdWtXQ2ZNOW53SWdEMWlBT3Y2?=
 =?utf-8?B?SFdtc255RnozQmNTeW9ud2hKODlrYjZKMmxyMWZSRDZSeWpkdlg5RzF5VGx1?=
 =?utf-8?B?UXU0Sm9ZUmk5NWw0YTUvMFBkMkRqUWp2SGVtY3BRNlVpbXZVZmlNWXhxVm1J?=
 =?utf-8?B?azhVejlTbWVPMUhvdXNMU2hoVEg4WTQ0UVlkV1pqN1FJdERQamgxazdBV0Ju?=
 =?utf-8?B?bXg4SUgxd1NXbkhBeFpNU0YxcGdvVVlQNlpNRWpMK1ZPaUoycTIyeXRPa3py?=
 =?utf-8?B?RnNDb3d0TjNhNHlBaTdwYkV6VkFoSFRpanVHNTNPMVloWHFjYTZjN1RHR3NG?=
 =?utf-8?B?ODF0ZU5WK2JGZnhHM0hCaUlDaUIybVc1MzI2TUQ3eFdCT2orN0d0NENtdGZs?=
 =?utf-8?B?UGNHU1Rrd1ZQRzEvM3NsUkFkZmFMUHNXdWxXNHJLTHZ6TGFiTEdsMlNlcGYx?=
 =?utf-8?B?b3diRG5aRXQ0VDdveEtoL2dHVUZrZGdzazFNN290emtDVEhMd05NYlpXc21s?=
 =?utf-8?B?YzAwek9VWnU1RU9sZ0E5aGtkYng1N2tHYXVpZjMxS1o1eHhPZjBGODJhNDVF?=
 =?utf-8?B?RVdleUI5cHdIL3BTVEI3bHZyekNFT0tzc2dYQjZROWgzWEs2VkFaOTFPVm1N?=
 =?utf-8?B?WTRKRHdUZTdFT0dHQzJSSUlNWXdSSERVbEpkV09wN3Q0SG85TW5HNlNpMm5R?=
 =?utf-8?B?YURVYjQyU3lrekhzV3RoTC85WVZBTzV6VFUvNWtMeFcrZlE2WkMvWjNtNFpE?=
 =?utf-8?B?Vy9HTm1wUkhhWldodGhlOGtjMXRWZ2tSRHBTQTZpZmdpUEtvUEJ2ZDl5SDIw?=
 =?utf-8?B?ZkVpSjVDd0NmK1hac1BXeFNkTDVoaFo0Njhid2FBV1lMUncva2hUUzlZTFZ0?=
 =?utf-8?B?SlRLbVRLYkduYzQ2ejVhRGM3MjF2dlFVaU93T1FVUFZJZ2FSZEhMUUZEbUhK?=
 =?utf-8?B?T3ltYkZBV0VjWnEzRk1iekxEQzZSdXplN1h6U2FPWFJBZXVWMVhHWWUwMlhn?=
 =?utf-8?B?NndUTHF4NFNFYTZnWTVmdEFGWjdwNHpQelJONSsxUTNpUGxMLytLbzVNZ2p1?=
 =?utf-8?B?c0JEeW5QUjdKTlViYTk3STNCTXlYQzYrMFJJMWlOeEJpbkw5NUs2WGFLc1R3?=
 =?utf-8?B?TUhsNzZ6YUM0TzF3S3lFTDB3Sm0rMm5YaENGQzhMdmlIV2p2dWIva24rN3p5?=
 =?utf-8?B?TUlhMjNxVkNYVHhpM3pOSWRURFMxcGpNMVNidjRhSnFoQ1NJNUVBV1gvdzB1?=
 =?utf-8?B?MUE3aDZhV1I5MEszTjlBdEQzb1paQ3NpWkUwQ0pwcjBYY295U2JDd0I0TnZr?=
 =?utf-8?B?VC9ieVJvZjV6dFlheFpDMTlDbGFvUDY1MFFDQ3dTQUsrSVpqUlBHODcva2RL?=
 =?utf-8?B?b0ZKbVM0TFo2c3A0enQ5aGJPSXg0a0UvL1lzZWxnOVlrWlA3bm5aaTdqRG5E?=
 =?utf-8?B?Y3BRSCt4VnlCOUdvdk55NUxEYi9kRlczNnRiQStVZlFmWWNJcTJNNlJGcEN0?=
 =?utf-8?B?Uit3Q0JsL1Q4RGlOSWltQ01XcE1BVEVDTlVkNGsvSkVsVnBpNTNPa2FERTVT?=
 =?utf-8?B?cGFibUFPMTUzSUtteW9Ra2NLMFp3UE5ZWlNHeDVpWXJHb0RXUDRkbVFXT0dS?=
 =?utf-8?Q?DFW91TQqfefv0NwZzbKBqIM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB6843.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TDhYczEreTZFQytZcUFpTS9aa0lmNG1OL0htZnYwL0lSK2xNeUw0eHNtcHYw?=
 =?utf-8?B?b25PNThBa3VFRE5wcVdkNEErNk5KNlg5dG96M0dFVnFGRHR1Z3ZQRnFOTHBw?=
 =?utf-8?B?b3Nodk52UExpaGFVU0E2bE1JS3VudEJ4NGNRQ0VGU0htTE5Db0NlenoyTGxD?=
 =?utf-8?B?WldvbVVxd0cwdWFEK2hRcVNWVVoyVnlKeU1pMVl4UG1ueHFpSmowQ3hNcmpm?=
 =?utf-8?B?K1pIRHd2N0E4Skk1SFhyMzRKd0Uwd0dHeGZOVmxFTE0waDM3c1QrSDB6Yks2?=
 =?utf-8?B?bnkwQjI2VEZHRDFvRGwxVXBrQ0JkcGc3a2YvYnRlQU1KSWVnbWNFRU00RmI0?=
 =?utf-8?B?d2xBR0V5M0llY09MbTdiNUlmZ0xscDcvZlRjS0xqaFU2dE5LWUFXQ0xiWjB2?=
 =?utf-8?B?UFpVdjl1NmsyV2FzVGlwV0g4RWxGbjh1N0MzUysraFh6SU56eThlSVd6aUVQ?=
 =?utf-8?B?TnRVQ1dwR244cW9zbTZIY1daUEVmRjBMOUw4Qmt2Y2ZWV295QWhCYm9WMDFR?=
 =?utf-8?B?QkQycmVaZVg0YTQxTkhqdXVKR3dDdnhqMk5rQmhac1Vxb1JNNVAvRGtPS29R?=
 =?utf-8?B?MkNkRCtJd0c3ZE9JTnJyZE16VmgyME15bkpWZUh6ZU1wYWp4aW1HSTdYU2xU?=
 =?utf-8?B?amRvUEQ2RkZkRElSd05MaktPOTlwbUM5WnZwYmhtUXBzUkJicHF2RkhldkRq?=
 =?utf-8?B?cEZneEtjRkdqUTZ1eU44bXpjMDZ6cWY1WVNMUDU4RjZxTVZnNDltNEZVdG9J?=
 =?utf-8?B?WE9WeFQ4SWJMVHVFQmgxUmMrZGtJRG9tMC9NYndrUG5RWDhaNWdnNENEY212?=
 =?utf-8?B?Y295cU1pV0tSWUdFeFlqMWt1eGZFeXpjT3kyZGJZS0tiYmhCQ0hCc245RVpB?=
 =?utf-8?B?TFZ2K0lFaGtHK1ZUVkc0d3c0c0VYMWI1cVdsNVJDb3RKZjBCMHlKZjdlQ1BH?=
 =?utf-8?B?ZG1EUENPM3BEZTRoL0ZSaGN4cXpENG0rT3YxTUd5WTZLeWpIbVRsMjdoWWdT?=
 =?utf-8?B?Tms3aG16NW84a3ZHN2l3YWZKMmpuK2xPSjB4elNzK2x0aVBmNGxMZWEzQ2ti?=
 =?utf-8?B?cGtnaVUzMzhMTURVdEJ1WHZHWkhZUDRIemF6MEt1NTh5b1Q4Tit6OHNiSjVD?=
 =?utf-8?B?WE9vQnpVbVF4SEtnY0NnUTEzQjN6aDhQbnJCaFhHOWVXQzhYelN4ekxsVk5u?=
 =?utf-8?B?RENFQnhmejd5dEtHeitUNW01d05ybEhkdWVUUnZyQjRZRnY5ZEI4cjltUFpE?=
 =?utf-8?B?NkxuQ2xPdktNZjFIby9hcnhKcWJVbFJmdC9TUnFXeE5ER2ZBWDF6VkVHQzhu?=
 =?utf-8?B?amJDTGkyYVg0c0U5Vlp6TDhYbjlrRTgrM0JBZnJWMEVjSnFaM21SRmgydUd6?=
 =?utf-8?B?UGRmMEFxME9oUCtNbVNIWWl5NFZMdDN5VEFGTGxPZ3pOendHRHJzRnFLNzB4?=
 =?utf-8?B?dEJYcVZnZWZyUklDeVBrWGNxU2EzOTRFUEc3S09yRVpyLzNmcUEzeFAzS2tJ?=
 =?utf-8?B?NXBUR3RERW9uUEtrNnFENXA2QVRoRzZkd1VWaUZWY0dZNVgrdm1pb2hBOUo3?=
 =?utf-8?B?Q1Q5TGhiL0RSS2dZUlVuWVJXUENrZkpUeVVzekFMbnlEdkhXb0VtcllDeklm?=
 =?utf-8?B?S09NcGNuWThKT0JvcFRvVzJLVkdISXhoVDNlYmY3VDVCTFNQSEdjSmU2UzJI?=
 =?utf-8?B?YmNXWENIWG5yc3QrOUNkN0JSNjhjSE11NGtkaC9NUW5IdFJTRkdFS3hzZmJB?=
 =?utf-8?B?dDVWeUEzYUEzTEdVYWdZNlNtMk9iUnNINUU2TXBSb2s4TWdHcDNYd2wvVlQv?=
 =?utf-8?B?anJObnh2VVJsanhOcks3a3NheTVNOUNWd1p4bTE3RERaRk02cU1tZUNaMG1Q?=
 =?utf-8?B?WThkazFKWXoyelg0UWFOUlp6ZzdLOGRuTVN5TGhuWWtNUCtaSm1kTXhLZjB1?=
 =?utf-8?B?RUpRZGtYMGMra051dWZoY1RpL2x1VS9SSitLalRQbnM0Tm94aVNKZ29aYjlo?=
 =?utf-8?B?OXJEb0lRMnJKTUFwSXdOMjVGaitXZWZVaDFkOStwRWJRdXNJMWErL3A5MVla?=
 =?utf-8?B?TGFpZDhOMElGWllyT0VDa3ZhdXhKRVN2UDNQcUZibW11YkhTYnNVNDdSOWpW?=
 =?utf-8?B?TGxoMHRiVTVWb1gvbm5qNkkzR3NycHFyMWxZOXJ3RjRnckZZZ1VMdHRZOEF4?=
 =?utf-8?B?ZHJCS09LaFZ0Z0NCT0g3R1BkOE5TVml2eExyL0VlZWxkNGxITVd5M0lpbDNV?=
 =?utf-8?B?REJVQllxelJDNkdxV2hsNzhyQ2h6RVRmbTJKZUgzN1JySVBoM2VuSUNsandP?=
 =?utf-8?B?NUpkVDdHOEZTZU5HV1pUTHVxc0IzbXArNmFFZ1IxTWw0a3BGT3FzOEFwSi9r?=
 =?utf-8?Q?wbmsufYqHy3tmP40=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E42A63696DD2C9458EC606CE63642101@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0jcxw2zbwiUDgryu2mDtv6BALQm3pSPeDXKcvmoRTS1BIe/DW881Ns9pyauU1sXjDPU89MEq/JaWW4grKOkfRMyhOMsC+bSGsvTcsqZ629I96grv0Odtd0pVxi+Z9eQTILlWcXwfAIGP9u0f6IUsuIVFkDI33ZoHl4cldXny9+mGchHBkqZLkCfIppA57EabQoTWbXjdidmU2E7QbYARLfp0d6RvCTV4DiyA8DsUZlfppHMVW6guy8ExCfbJH1i1hXLxg+27ZC4OoEChdEv9CbBnvzMNP9uCci4zBtXxYZ1Gp72in72sN9QJOSndmKBsGoO71ju69bxNdyaKyYwZcn1dq+YuPkTW8cSTw+GkFJ1oknrzgmkUEXvZckjnzvT+KnZGmagP6M49fIFn70tzM6TCKVwU9U5F/1PNwiOCGNnXo54N4X/fOPULmh7ui+vnZJoecttKnTibcSJc7WF7jkEYB7yHU4Rn4S9Ee2WnScmqmv9kevsTq24asy5fA1i1GGLUJdl1HxS8Yn2p0pQeYPnQKUboPz8tA9hYoIR1CP/lkqFp0CXuJ2biCqojUz6PS1l1xXQvkRe9qVMxG+YZJwrFE9k+jesZIR+JKvC4hFg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB6843.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405b73d2-bf46-4aaf-ac82-08de599a999b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 09:42:46.9783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sl7Gb8GFg5Kbw+HoYX2rbVHo7vKZMz9yQC7FhYNmAbx72f+CpkgDc72WOkdU9DhRGXcDEePrWT7wkmYK4sY4dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220066
X-Proofpoint-ORIG-GUID: hDFp1JElPGNHuSh85s9i6QhLlsjO_mMV
X-Authority-Analysis: v=2.4 cv=IsYTsb/g c=1 sm=1 tr=0 ts=6971f11f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iwl1xY0uQyKUsFideyYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA2NyBTYWx0ZWRfX9d6CqVEdGDsy
 eMktbGS9aX6C3SiMiTVnfkkoR5haVXfWO7lqgty+uo/PnUuW+yLi/anae0tNavGSKdp2e6BrmTF
 Frp4SjmGedJYxZqx0WdNjV7uOM5rEJILsZT5L55ktiZOgAJvnM/PETpJOkNgCWjGUMshurGrMp6
 hXNI5WFVMteM4J/0VY9Ajd/W2g6iq1z5fTqulEdHZ0xxeJ5BtD/aDOrgPSOWSs8PpJtjiikXfZk
 M5qGO89w+A57QsIsfUkEzm5ah1bkVcrOqVDfv00vzIgurSUVZWufbbUbu0rG/FS6PSbMk1XC/OQ
 1dHXxVZO6xfJVutKaVcdw/ctSb9HJYZcFHwlD0iFARv05nBN8UYw3MSvaB88n7k33aqOj890Wd7
 ol7UYjzGtvQ6dCcgBEmamXpucGseB/F95V0XVTqVvy75IhrmuBdz0Cv24FVlByAzYjfjwPwMPY9
 OXhwICmAd4U2upkxbKQ==
X-Proofpoint-GUID: hDFp1JElPGNHuSh85s9i6QhLlsjO_mMV
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20510-lists,linux-acpi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[google.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haakon.bugge@oracle.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[oracle.com,reject];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 05FD264C8A
X-Rspamd-Action: no action

PiBPbiBXZWQsIEphbiAyMSwgMjAyNiBhdCAxMjozNTo0MFBNICswMTAwLCBIw6Vrb24gQnVnZ2Ug
d3JvdGU6DQo+IFtzbmlwXQ0KDQo+IFJDQiBpc24ndCBtZWFuaW5nZnVsIGZvciBzd2l0Y2hlcywg
c28gd2UnbGwgcmVhZCB0aGVpciBMTktDVEwNCj4gdW5uZWNlc3NhcmlseS4gIEkgcHJvcG9zZSBz
b21ldGhpbmcgbGlrZSB0aGlzLCB3aGljaCBhbHNvIGNsZWFycyBSQ0INCj4gaWYgaXQncyBzZXQg
d2hlbiBpdCBzaG91bGRuJ3QgYmUgKEkgdGhpbmsgdGhpcyB3b3VsZCBpbmRpY2F0ZSBhDQo+IGZp
cm13YXJlIGRlZmVjdCk6DQo+IA0KPiAgICAgICAgLyoNCj4gICAgICAgICAqIFBlciBQQ0llIHI3
LjAsIHNlYyA3LjUuMy43LCBSQ0IgaXMgb25seSBtZWFuaW5nZnVsIGluIFJvb3QgUG9ydHMNCj4g
ICAgICAgICAqICh3aGVyZSBpdCBpcyByZWFkLW9ubHkpLCBFbmRwb2ludHMsIGFuZCBCcmlkZ2Vz
LiAgSXQgbWF5IG9ubHkgYmUNCj4gICAgICAgICAqIHNldCBmb3IgRW5kcG9pbnRzIGFuZCBCcmlk
Z2VzIGlmIGl0IGlzIHNldCBpbiB0aGUgUm9vdCBQb3J0Lg0KPiAgICAgICAgICovDQo+ICAgICAg
ICBpZiAoIXBjaV9pc19wY2llKGRldikgfHwNCj4gICAgICAgICAgICBwY2lfcGNpZV90eXBlKGRl
dikgPT0gUENJX0VYUF9UWVBFX1JPT1RfUE9SVCB8fA0KPiAgICAgICAgICAgIHBjaV9wY2llX3R5
cGUoZGV2KSA9PSBQQ0lfRVhQX1RZUEVfVVBTVFJFQU0gfHwNCj4gICAgICAgICAgICBwY2lfcGNp
ZV90eXBlKGRldikgPT0gUENJX0VYUF9UWVBFX0RPV05TVFJFQU0gfHwNCj4gICAgICAgICAgICBk
ZXYtPmlzX3ZpcnRmbikNCg0KSSBzZWUgdGhhdCBzZWMgMS4zLjIgZGVmaW5lcyAiRW5kcG9pbnRz
IGFyZSBjbGFzc2lmaWVkIGFzIGVpdGhlciBsZWdhY3ksIFBDSSBFeHByZXNzLCBvciBSb290IENv
bXBsZXggSW50ZWdyYXRlZCBFbmRwb2ludHMgKFJDaUVQcykuIiBCdXQsIHNob3VsZG4ndCB3ZSBh
bHNvIGV4Y2x1ZGUgUm9vdCBDb21wbGV4IEV2ZW50IENvbGxlY3RvcnMgKFBDSV9FWFBfVFlQRV9S
Q19FQyk/DQoNCj4gICAgICAgICAgICAgICAgcmV0dXJuOw0KPiANCj4gICAgICAgIHJjYiA9IHBj
aWVfcm9vdF9yY2Jfc2V0KGRldik7DQo+IA0KPiAgICAgICAgcGNpZV9jYXBhYmlsaXR5X3JlYWRf
d29yZChkZXYsIFBDSV9FWFBfTE5LQ1RMLCAmbG5rY3RsKTsNCj4gICAgICAgIGlmIChyY2IpIHsN
Cj4gICAgICAgICAgICAgICAgaWYgKGxua2N0bCAmIFBDSV9FWFBfTE5LQ1RMX1JDQikNCj4gICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm47DQo+IA0KPiAgICAgICAgICAgICAgICBsbmtjdGwg
fD0gUENJX0VYUF9MTktDVExfUkNCOw0KPiAgICAgICAgfSBlbHNlIHsNCg0KSSB3YXMgdGhpbmtp
bmcgdGhhdCBzaW5jZSBzZWMgNy41LjMuNyBzdGF0ZXMgKGZvciBFbmRwb2ludHMgYW5kIEJyaWRn
ZXMpOiAiRGVmYXVsdCB2YWx1ZSBvZiB0aGlzIGJpdCBpcyAwYi4iLCB0aGF0IHRoaXMgY2FzZSBk
aWRuJ3QgaGFwcGVuLiBCdXQgb2YgY291cnNlLCBhIGRlZmVjdCBCSU9TIHNob3VsZCBiZSBjb25z
aWRlcmVkLg0KDQpBIHYzIGlzIG9uIGl0cyB3YXkuDQoNCkkgcmVhbGx5IGFwcHJlY2lhdGUgeW91
ciBkaWxpZ2VudCByZXZpZXcsIEJqb3JuIQ0KDQoNClRoeHMsIEjDpWtvbg0KDQoNCj4gICAgICAg
ICAgICAgICAgaWYgKCEobG5rY3RsICYgUENJX0VYUF9MTktDVExfUkNCKSkNCj4gICAgICAgICAg
ICAgICAgICAgICAgICByZXR1cm47DQo+IA0KPiAgICAgICAgICAgICAgICBwY2lfaW5mbyhGV19J
TkZPICJjbGVhcmluZyBSQ0IgKFJDQiBub3Qgc2V0IGluIFJvb3QgUG9ydClcbiIpOw0KPiAgICAg
ICAgICAgICAgICBsbmtjdGwgJj0gflBDSV9FWFBfTE5LQ1RMX1JDQjsNCj4gICAgICAgIH0NCj4g
DQo+ICAgICAgICBwY2llX2NhcGFiaWxpdHlfd3JpdGVfd29yZChkZXYsIFBDSV9FWFBfTE5LQ1RM
LCBsbmtjdGwpOw0KPiANCj4+ICt9DQo+PiArDQo+PiBzdGF0aWMgdm9pZCBwY2lfY29uZmlndXJl
X2RldmljZShzdHJ1Y3QgcGNpX2RldiAqZGV2KQ0KPj4gew0KPj4gCXBjaV9jb25maWd1cmVfbXBz
KGRldik7DQo+PiBAQCAtMjQxOSw2ICsyNDU0LDcgQEAgc3RhdGljIHZvaWQgcGNpX2NvbmZpZ3Vy
ZV9kZXZpY2Uoc3RydWN0IHBjaV9kZXYgKmRldikNCj4+IAlwY2lfY29uZmlndXJlX2FzcG1fbDFz
cyhkZXYpOw0KPj4gCXBjaV9jb25maWd1cmVfZWV0bHBfcHJlZml4KGRldik7DQo+PiAJcGNpX2Nv
bmZpZ3VyZV9zZXJyKGRldik7DQo+PiArCXBjaV9jb25maWd1cmVfcmNiKGRldik7DQo+PiANCj4+
IAlwY2lfYWNwaV9wcm9ncmFtX2hwX3BhcmFtcyhkZXYpOw0KPj4gfQ0KPj4gLS0NCj4+IDIuNDMu
NQ0K

