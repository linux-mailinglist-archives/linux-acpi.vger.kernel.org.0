Return-Path: <linux-acpi+bounces-8072-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F77967FD8
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2024 08:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85DB1F214B4
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2024 06:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5354715688F;
	Mon,  2 Sep 2024 06:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FoFx8FoT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B5D2032A;
	Mon,  2 Sep 2024 06:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260335; cv=fail; b=Jju4QoAqkqoAsXtjG4BtYqI/uPNCIk4i7Q8padTWU47SaTFQiw+Y7jrJUKo2359bcxlk7tXNn4SwAHm5yVTTFvBnX0H/3II/QmM1PzkRi7lWKRSk5vWbQsdnWA8tBXt/koogvxnrLIfOcE02LieV9+V8wDcnQP5eye0gLaRnmdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260335; c=relaxed/simple;
	bh=KzRwVHRqpkkBHshutF6duqrXSXLgnrJ5oAjnHpQ/j8k=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m69TDxSdwpD1m7t+nY7jjfDvAxvQcjOiQqxc9KvDA0EBdPVvTDnAMlUSA61+HE4rcnq5jc0yw7ThoNGBDOKA+6eh6XVU6oyxg6igWvJbVySL4SdcuUyQjddNLTVRIX9W107b4wIgoKw1qf5AzjWNi332+2dY42uLnOhnFcUFTIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FoFx8FoT; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/+cj5SRD/w3iygZQUQdTonyN0GYfi7dn1GprgZtAvJzEkxvFOjsbfPFmJS8wxWi+39SM/uJX8BKUORrAlRw5UsiSVazQ98UDgIPds5tNChS4wyDd+aPXml0WsvDvDgcJXvLJMf/vy3mU6uu79oErKmSNDiZXiOl01buiTUfsmT0KoeyOFpDrW2DTkfdeHOxwo/adqBf+zrT90Fbs9kkfFerFge0XdsvgWNPtaYGE+e4oHV0J9ur7muAdTJ+cGBQ1hlYd9s0s48e9ex6co/pCI6O/267YkCD9OfKoV3MH17pO5Q1rBOGj5tPk9Q87B4d4nP+ymM1HoI7krgebwssBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ot7/9Y+NPtzSomEXAaGCkDFr6jBjjR6fwYX9iR35gfM=;
 b=EmOtL3Ythou2/g72lRAdjvbIPnhTYaETHwUv0D5JUmLRj7pEnFkCprnBDAKgCkLnb/Uq+MebYaMFrxtk+saegE6E9U5mEXkRpZe95lPkcvJqsi7py1V3pFJyE90iSVgZzlOhxFNuTY6niDjsqSPVCW6Nu+/GpehFrc7Iq4u/ae7zmOLvh/riJ4RdhUbZmztVlxoOJYgrjceU5AKd8Et29s2vjNC12GWEZgX3WTPpgxJty40YHHo4C7RjxorNEGQEnZOIdcdI7cM8ii8s2EbY32hHAoXHTca9q5I9k9Nqesxj5MI8XEVni83wDsh+bmMJHkFcfD3ajpSWrVETJMSIew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ot7/9Y+NPtzSomEXAaGCkDFr6jBjjR6fwYX9iR35gfM=;
 b=FoFx8FoT0Xh+8ML92TRL2G4KAy12kL7OzPMdEY2PHg5WBDCMvK1CrrdjuRxjmqZ7qio1QJ3HCyahKocpmD44Ga52Xk1kvZIk1A3VFdEiWyMQrLJM5ORpV0IcKUG45/x6JR4wFtS6Tl+wYxXsM9J4Nai1xYt66GWaJ1aBFGs1j4LUJWqyEMi0qAucAy3sCePhetilV+qfmxB7AnSIuedPMjn49D4WAcCNA6dET+7+LZnxqo3ftvKod+vKRQbp5EUSdAgIudTQfzOhaJzJGmQEi2s4RKls+IrbGqn5bpEZVIKMPMKg+2f6L+SWwCQw8LAp3z8bFs7z161xAA7IjJUjCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 by CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 06:58:49 +0000
Received: from CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4]) by CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4%5]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 06:58:49 +0000
Message-ID: <b2156886-0356-4eed-84f0-278a1b30ce32@nvidia.com>
Date: Mon, 2 Sep 2024 14:58:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] acpi/prmt: find block with specific type
To: "Zhang, Rui" <rui.zhang@intel.com>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
 <lenb@kernel.org>, "mochs@nvidia.com" <mochs@nvidia.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20240901162255.1302358-1-kobak@nvidia.com>
 <afec8c0c7b92de59469e789cff4ba8a11f631217.camel@intel.com>
Content-Language: en-US
From: Koba Ko <kobak@nvidia.com>
In-Reply-To: <afec8c0c7b92de59469e789cff4ba8a11f631217.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::25) To CY8PR12MB8297.namprd12.prod.outlook.com
 (2603:10b6:930:79::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8297:EE_|CY8PR12MB8300:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f98411-fecb-4e8f-2744-08dccb1cb28e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aitiQ3FZMkEwZDJtZ1kwTmpiMDhJT1VONVdSSjdCeGw5WjZDVURneHpRMHhU?=
 =?utf-8?B?Yk1YQTFoWkN6QnpOK1BhZDk5eVBuM2syQ2VLcFFkT3dUb0g2Wis2SDlSQjAr?=
 =?utf-8?B?Q25kVjIrT1N2MmRqR1pxeVpQaTlvT2wxelpiVXA1K0xoaWN6Rm8zQ2o3RDh5?=
 =?utf-8?B?ZWlWbFJ3cVRvd1VRTU54bmxvMkpIOVJ6YjREbTJZSFczQVJRdVFaNHBrQkVz?=
 =?utf-8?B?OGFpZUw0WldUdXFMSm13d2xJZDRrTEN1VnZlc0pmc0NGVVhPcmJvRC9TWCs2?=
 =?utf-8?B?b0IvVUp5aUxQZTQ1bVZYU2J6V1BMZFpDTlRXVXhMdGxmWEFrTHNud3lJVVk4?=
 =?utf-8?B?b2IrRHZ3R0RaVUJJc0x5SFdsd1IwWWNpMXdaNlVrQlJrWlNOZTRuUUZZRFFT?=
 =?utf-8?B?ZDVCL3BJaHN3N0I5dGwxdkt1K2h1UkZKL3BHNk9LV1orSnI4QTd2RGlpWVlT?=
 =?utf-8?B?NFhYNVpaMG1HYzU0dnY3OU5mcUVBQkgxMnhvZ0dTbCtQZzVMaE9Wd3RkTWlS?=
 =?utf-8?B?aU5YQWc0VUl6SDBkeUY3MnlEV1lkYUJDWFhVakkyVEJvRjFhd3paWmdGUDJI?=
 =?utf-8?B?SHhLa2M5N3dONVFjZXFCWnc0SDhUZWVDdzhMTGJpOG13VlRoNDdEenJxbllI?=
 =?utf-8?B?TkNiTzZSUEtnV1pOU3VIVUpnNzNwWlpqRmE3QzVCQjZDTkdqWlJSZ3VlTWZa?=
 =?utf-8?B?cEUwOHF6cHh6cGd1ckg5YUxxTUZqamV2QlV0TXFVMTFoUDZaUnd4eitTcksx?=
 =?utf-8?B?UlBDeUFhRWFFbHZUWmkrdE9KdnRta1ZWRHAvWUwvV0EvaDJGanZOamtWamtE?=
 =?utf-8?B?S0JTSzBManIyUC82K3NQTUlZMm1Vc3NJVkZxTWVKSDZkNnRHRW15RWY3RExS?=
 =?utf-8?B?NTh0d3NSRmlZMEFOa0dsOFRxMVZ1QksxcG1JQ3RjazRxQnZDeXNKR0QrM2JC?=
 =?utf-8?B?WGE4eFdoR0hJTGl2RjdlejRoanFyM3lrd3B5K0NmTFd6YVZpVDNvY1BxNXRh?=
 =?utf-8?B?TGJjSnJpU3ZFTFBJcm01SGxkNlMrRmRwWFloOUVSaHpTNUNqQ3Uwc1RLcTVG?=
 =?utf-8?B?d1ZHK2dZbTRQNW41dFc4aXhLbkhlbTdWK2ZKRUZJRmVvb1NZbkgvdWZrRlA2?=
 =?utf-8?B?bC9aQ0hRc01VTWpKSXNKQkZ1SmVXdDlMQ1AvelVFVE9ZcWtqaTFxcnNWZDBR?=
 =?utf-8?B?azVxWmVMN3M2a25VVzh6OVljY0h4d0pCRWdpYURHOHd3VjFFenNmZVI3K2R1?=
 =?utf-8?B?bng4YUNGMm12am4rQWI0dlZhYmVmejlRcEFybGdlQ1R6dWFsbEJIckx5Uk1n?=
 =?utf-8?B?N1pycngzOXlMSmNJY3dDeEtFUUZzVm1qVUR2QmRodzd6TndzR3ZYSXNwa1cw?=
 =?utf-8?B?cGlPbnI5cUFldGZoT2dxRUtlNDVvdlR0ZmdrQjRQSm9EL2xSQktVWVIzRFB3?=
 =?utf-8?B?NStZWXhsM0M5YVVDb0l5NnZNbU9iMmdhamJWbjFDSWtDVG5QeWlPNDVLVjh5?=
 =?utf-8?B?Uk45VThvbTE0MUhCRGtSQWp2K3VHSmpXMmNncTI3WXFVOW1TV2hxaERSWnpQ?=
 =?utf-8?B?Y1JpMlZlKzhYbUcxM3RwMDZmanFmZXczeFhXSXVoMi9RV0ZDMGZzOTAyeTVE?=
 =?utf-8?B?R1JMeE5weUp0aXRlMGMyOTZ2U1UrL21lRlZJTlRQY3hKbmVJZU5XMzZWS1Jj?=
 =?utf-8?B?MDJEbDdDMVdibU1JK0hQOW54ZURnSW5yaUhFTkxBa0dYVldjTFR4MXU1K2pW?=
 =?utf-8?B?TTQ3SlpzbkMyeFZEWXMwN2kyL0VQTHBjVER1NURPK3ZXbzlCZTRVV0NQcmdo?=
 =?utf-8?B?bEc1aUJaNksvdjhmeVF0dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8297.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3VSRmVHVWcyM09yZHF4YzNFejZVRmlyVkV2QnVzZXhiOXRTdHZ1eUFaK25Y?=
 =?utf-8?B?QVdZSkhFZTE2TFUvY3F5Q3VQMTc2Sk9GSVkvVTJMZVFKb1FZclVyNDlLUWV0?=
 =?utf-8?B?Y291TVk0TDZpbWxjUXVQRlZVUEhTVVJxSVV1cDhlamVqbjBiUS9VVXhlVTJy?=
 =?utf-8?B?K3ArN1cwdUJzazZJcTZxOC9aMXEzR0JWU2F5ampiRHMrRzV6b3VVMldCM01v?=
 =?utf-8?B?OUV0d2xOeVNJNDdjaDcxOWlQMktjRFV6b0dWUmNVMnloejVEcS82dEVNMTNt?=
 =?utf-8?B?ZTkrdVJnRWtVbnl4SExZK05VY2U3b1lVQkhhd2Y4bmg0a0NWWUJSZFF1c1lP?=
 =?utf-8?B?NHpDbC9XcUNaWDZpQlNFUVVMMFhQcUIzL2oyZStSalQzZG1PRExvWXVQcW9u?=
 =?utf-8?B?T3QyRXVXQW1HdnlzeTBpL3BSdVdzK2NmZFU3dWlHZE9IUkgzeVBlY1FvdkQw?=
 =?utf-8?B?KzBJNWMySDRoUGlYSzFucGRaUEhjWitDVGdmNGUwQm5pTUhQTy80bGVOZmRo?=
 =?utf-8?B?cTFZaUdZTXQ5SU9JQmhpODg2S3QrMmQ1U1FSNEF3TlRPRE5samRWdlZuS2Jo?=
 =?utf-8?B?YTVId2ZadkhxelhvNTI5YzZsK0tGUVFhTVNSQWJFNlkrK0FZQ21hVEprTkRx?=
 =?utf-8?B?c2thNmh4aTdHL3ErQWVkNUVXWmZxSCtDRnhiTDc4S2hGTUNIT3lvWDFmRnA4?=
 =?utf-8?B?Z04zSXpHTmFWTmFWekwvSitabld4ZmgvREMwUUdWaENjVXlFWDRIU2hRUDNY?=
 =?utf-8?B?Qk12ZEJMRUZoTStaazVBQmRYaTVUamVMUEVYZVFCdFg3Z1VMTGJHMDBUMVp2?=
 =?utf-8?B?ckd0R2JBWVJtSm43L04wc2pVZWNKbFRJaUdreG5uOVdvMVVMdXpOY2ViM3R5?=
 =?utf-8?B?d1VxT3JOaFd6aEZmTmhpangyenIxYzFjV1Z1eWtuZkkyanJmQy9VTTR5TFAr?=
 =?utf-8?B?b0pCbmV6bGNia1R6cjdOS1lZbnoybmZqSHZ5bVRwMFRTa1lmR0J5cjZWLy95?=
 =?utf-8?B?VTBQcWxJWTArVWcrQzVONXc3ZlU1aGw5d1lGdlhUZUx5a2d4UmFHcnkrTys4?=
 =?utf-8?B?N2ViQ3RvVFJIdGVNRmwvT0w1VjV1aEIzdmF3T1RseVZQSnBIYTZoNW91MnMy?=
 =?utf-8?B?Q1FJbVRhblh4bzNIQ1JlSm42cVVFSXVGR1VDYmpoNGhsYi9yc3pEbTJQeXR6?=
 =?utf-8?B?NVNDMnIzQWx2S2NWTE4zQnZwb05XK2hnMVBaZXpZb0JodzdUVStDYWVrMWNH?=
 =?utf-8?B?ZDVaSXZhRitCbnptV1VmZnMwSkg1V291aklmVm54cGFYN3Z2RzhLRGJMSGFF?=
 =?utf-8?B?c3VqL0pWdEVkVzJHNzJLbGlacVQ1VFJkY1hXM2lTL2xTc1I2QlBrVkFkMTYv?=
 =?utf-8?B?N3d1Z242WnVZMXVOSW9xS2pIcW1haVUvbEJvN2l4bmhaTEdtTCtodmxFN1JW?=
 =?utf-8?B?OEFYNk5HRk1uei91U1pmYzFhNGRPUjZUU3UyOExzdkpvZC85a3dick5JWEpU?=
 =?utf-8?B?bzZIYkZ0cGFYcWZkVzFtUUoxU0d5U0hpaFBCeFpIYXZ5QWxEbzBNMnltelNG?=
 =?utf-8?B?elp6aWRiSzJLTlhlaTdpQTA2SzhzVDMwL1ZUSWhleWd6SWdCVGdTMGJLN1du?=
 =?utf-8?B?SjZ0enlibk1TRmtPM0FGQkFQaVBoT29wRHpHRDRlVXg5R203WUlXMndIZWpE?=
 =?utf-8?B?R3RqNTE3Vjh1NERDQ2VWYnRFV1ZWY2tTdWhWMG0zK0V3U09UY0FmTnpqVC9o?=
 =?utf-8?B?SDErUUNJUjhnTnFNaVpTTUZxSDlscWYzQXZoWFlRRGNCUDcrdzFuOGtwN3V5?=
 =?utf-8?B?WWo0cnVKTUVSV2lFcjFIT1JCalN3SC8vbVcvcVdka3NnbGV6d2Q2VDJuY3dY?=
 =?utf-8?B?eEczc1FTaUQ1c21CZ3UxRkdXeE5aYWxHT2Vjc21ER1dOeVpLK1BnWC9ZWFd1?=
 =?utf-8?B?VWFnQ3JyU211N1J5cDl1Unh1T25LNHVaWFN1Z1RNNk9WMnU0dlJJTDFiY1Qx?=
 =?utf-8?B?OVhxNGlJcEt6bU03SkdkZEdRKzdNZ3EyVS81a2xwVW5iU2h0eDVmU0pDMkoy?=
 =?utf-8?B?eEdtK3RTZWNudWZBTmxkWlZEeDdSNVo2aEw1Nk5uOHpwaGtxRE5JQmp4c0JC?=
 =?utf-8?Q?LG9utC14YBdT483AJ6GsN3Drw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f98411-fecb-4e8f-2744-08dccb1cb28e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8297.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 06:58:49.6476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RsWMDq6/badi4Oy/fnQz3CQNRp5n9cjm/4aP5+/XYPkypOaAgf8r1ahwAlVrXiM4je312pzN045/hy/LPae8uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8300

On 9/2/24 14:36, Zhang, Rui wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, 2024-09-02 at 00:22 +0800, KobaK wrote:
>> PRMT needs to find the correct type of block to
>> translate the PA-VA mapping for EFI runtime services.
>>
>> The issue arises because the PRMT is finding a block of
>> type EFI_CONVENTIONAL_MEMORY, which is not appropriate for
>> runtime services as described in Section 2.2.2 (Runtime
>> Services) of the UEFI Specification [1]. Since the PRM handler is
>> a type of runtime service, this causes an exception
>> when the PRM handler is called.
>>
>>      [Firmware Bug]: Unable to handle paging request in EFI runtime
>> service
>>      WARNING: CPU: 22 PID: 4330 at drivers/firmware/efi/runtime-
>> wrappers.c:341
>>          __efi_queue_work+0x11c/0x170
>>      Call trace:
>>        __efi_queue_work+0x11c/0x170
>>        efi_call_acpi_prm_handler+0x68/0xd0
>>        acpi_platformrt_space_handler+0x198/0x258
>>        acpi_ev_address_space_dispatch+0x144/0x388
>>        acpi_ex_access_region+0x9c/0x118
>>        acpi_ex_write_serial_bus+0xc4/0x218
>>        acpi_ex_write_data_to_field+0x168/0x218
>>        acpi_ex_store_object_to_node+0x1a8/0x258
>>        acpi_ex_store+0xec/0x330
>>        acpi_ex_opcode_1A_1T_1R+0x15c/0x618
>>        acpi_ds_exec_end_op+0x274/0x548
>>        acpi_ps_parse_loop+0x10c/0x6b8
>>        acpi_ps_parse_aml+0x140/0x3b0
>>        acpi_ps_execute_method+0x12c/0x2a0
>>        acpi_ns_evaluate+0x210/0x310
>>        acpi_evaluate_object+0x178/0x358
>>        acpi_proc_write+0x1a8/0x8a0 [acpi_call]
>>        proc_reg_write+0xcc/0x150
>>        vfs_write+0xd8/0x380
>>        ksys_write+0x70/0x120
>>        __arm64_sys_write+0x24/0x48
>>        invoke_syscall.constprop.0+0x80/0xf8
>>        do_el0_svc+0x50/0x110
>>        el0_svc+0x48/0x1d0
>>        el0t_64_sync_handler+0x15c/0x178
>>        el0t_64_sync+0x1a8/0x1b0
>>
>> Find a block with specific type to fix this.
>> prmt find a block with EFI_RUNTIME_SERVICES_DATA for prm handler and
>> find a block with EFI_RUNTIME_SERVICES_CODE for prm context.
>> If no suitable block is found, a warning message will be prompted
>> but the procedue continues to manage the next prm handler.
>> However, if the prm handler is actullay called without proper
>> allocation,
>> it would result in a failure during error handling.
>>
>> By using the correct memory types for runtime services,
>> Ensure that the PRM handler and the context are
>> properly mapped in the virtual address space during runtime,
>> preventing the paging request error.
>>
>> [1]
>> https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf
>>
>> Fixes: cefc7ca46235 ("ACPI: PRM: implement OperationRegion handler
>> for the PlatformRtMechanism subtype")
>> Signed-off-by: KobaK <kobak@nvidia.com>
>> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
>> ---
>> V2:
>> 1. format the changelog and add more about error handling.
>> 2. replace goto
>> ---
>>   drivers/acpi/prmt.c | 47 ++++++++++++++++++++++++++++++-------------
>> --
>>   1 file changed, 32 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
>> index c78453c74ef5..281cdb53eddb 100644
>> --- a/drivers/acpi/prmt.c
>> +++ b/drivers/acpi/prmt.c
>> @@ -72,17 +72,21 @@ struct prm_module_info {
>>          struct prm_handler_info handlers[]
>> __counted_by(handler_count);
>>   };
>>
>> -static u64 efi_pa_va_lookup(u64 pa)
>> +static u64 efi_pa_va_lookup(u64 pa, u32 type)
>>   {
>>          efi_memory_desc_t *md;
>>          u64 pa_offset = pa & ~PAGE_MASK;
>>          u64 page = pa & PAGE_MASK;
>>
>>          for_each_efi_memory_desc(md) {
>> -               if (md->phys_addr < pa && pa < md->phys_addr +
>> PAGE_SIZE * md->num_pages)
>> +               if ((md->type == type) &&
>> +                       (md->phys_addr < pa && pa < md->phys_addr +
>> PAGE_SIZE * md->num_pages)) {
>>                          return pa_offset + md->virt_addr + page - md-
>>> phys_addr;
>> +               }
>>          }
>>
>> +       pr_warn("PRM: Failed to find a VA block for pa: %lx type
>> %u\n", pa, type);
>> +
>>          return 0;
>>   }
>>
>> @@ -148,9 +152,12 @@ acpi_parse_prmt(union acpi_subtable_headers
>> *header, const unsigned long end)
>>                  th = &tm->handlers[cur_handler];
>>
>>                  guid_copy(&th->guid, (guid_t *)handler_info-
>>> handler_guid);
>> -               th->handler_addr = (void
>> *)efi_pa_va_lookup(handler_info->handler_address);
>> -               th->static_data_buffer_addr =
>> efi_pa_va_lookup(handler_info->static_data_buffer_address);
>> -               th->acpi_param_buffer_addr =
>> efi_pa_va_lookup(handler_info->acpi_param_buffer_address);
>> +               th->handler_addr =
>> +                       (void *)efi_pa_va_lookup(handler_info-
>>> handler_address, EFI_RUNTIME_SERVICES_CODE);
>> +               th->static_data_buffer_addr =
>> +                       efi_pa_va_lookup(handler_info-
>>> static_data_buffer_address, EFI_RUNTIME_SERVICES_DATA);
>> +               th->acpi_param_buffer_addr =
>> +                       efi_pa_va_lookup(handler_info-
>>> acpi_param_buffer_address, EFI_RUNTIME_SERVICES_DATA);
> why not remove pr_warn() in efi_pa_va_lookup(), and check for all three
> addrs here with a more detailed message about which part is missing for
> which module/handler?

This's a good idea,
I'm planning to continue the next prm handler once the failure happens.
also prompt the warning message about which part is missing.
the missing parts have zero address.
e.g.
if(!handler_addr || !static_data_buffer_addr || !acpi_param_buffer_addr)
    pr_warn (
        "Idx: %d, Parts of handler(GUID: %pUB) are missed, handler_addr 
%llx, data_addr %llx, param_addr %llx",
        cur_handler, handler_addr,
        static_data_buffer_addr, acpi_param_buffer_addr);

>
>>          } while (++cur_handler < tm->handler_count && (handler_info =
>> get_next_handler(handler_info)));
>>
>>          return 0;
>> @@ -250,8 +257,18 @@ static acpi_status
>> acpi_platformrt_space_handler(u32 function,
>>
>>                  handler = find_prm_handler(&buffer->handler_guid);
>>                  module = find_prm_module(&buffer->handler_guid);
>> -               if (!handler || !module)
>> -                       goto invalid_guid;
>> +               if (!handler || !module) {
>> +                       buffer->prm_status =
>> PRM_HANDLER_GUID_NOT_FOUND;
>> +                       pr_err("PRM: PRM Handler GUID is not
>> found\n");
> Are you sure you want to get this error message every time the address
> space handler is invoked, rather than give an one time warning during
> the handler probe time?
>
> thanks,
> rui

the 1st idea is good.
if it's applied, I agree your comment here, too.
Thanks, i will send v3.

>> +                       return AE_OK;
>> +               }
>> +
>> +               if (!handler->handler_addr || !handler-
>>> static_data_buffer_addr ||
>> +                       !handler->acpi_param_buffer_addr) {
>> +                       buffer->prm_status = PRM_HANDLER_ERROR;
>> +                       pr_err("PRM: PRM Handler not found\n");
>> +                       return AE_OK;
>> +               }
>>
>>                  ACPI_COPY_NAMESEG(context.signature, "PRMC");
>>                  context.revision = 0x0;
>> @@ -274,8 +291,10 @@ static acpi_status
>> acpi_platformrt_space_handler(u32 function,
>>          case PRM_CMD_START_TRANSACTION:
>>
>>                  module = find_prm_module(&buffer->handler_guid);
>> -               if (!module)
>> -                       goto invalid_guid;
>> +               if (!module) {
>> +                       buffer->prm_status =
>> PRM_HANDLER_GUID_NOT_FOUND;
>> +                       return AE_OK;
>> +               }
>>
>>                  if (module->updatable)
>>                          module->updatable = false;
>> @@ -286,8 +305,10 @@ static acpi_status
>> acpi_platformrt_space_handler(u32 function,
>>          case PRM_CMD_END_TRANSACTION:
>>
>>                  module = find_prm_module(&buffer->handler_guid);
>> -               if (!module)
>> -                       goto invalid_guid;
>> +               if (!module) {
>> +                       buffer->prm_status =
>> PRM_HANDLER_GUID_NOT_FOUND;
>> +                       return AE_OK;
>> +               }
>>
>>                  if (module->updatable)
>>                          buffer->prm_status =
>> UPDATE_UNLOCK_WITHOUT_LOCK;
>> @@ -302,10 +323,6 @@ static acpi_status
>> acpi_platformrt_space_handler(u32 function,
>>          }
>>
>>          return AE_OK;
>> -
>> -invalid_guid:
>> -       buffer->prm_status = PRM_HANDLER_GUID_NOT_FOUND;
>> -       return AE_OK;
>>   }
>>
>>   void __init init_prmt(void)

