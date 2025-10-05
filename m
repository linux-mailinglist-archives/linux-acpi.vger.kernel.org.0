Return-Path: <linux-acpi+bounces-17588-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C05BB9338
	for <lists+linux-acpi@lfdr.de>; Sun, 05 Oct 2025 02:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E51AB34522C
	for <lists+linux-acpi@lfdr.de>; Sun,  5 Oct 2025 00:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B28413C8EA;
	Sun,  5 Oct 2025 00:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N65kl0JJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012052.outbound.protection.outlook.com [40.107.200.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4D386334;
	Sun,  5 Oct 2025 00:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759625611; cv=fail; b=r9jCMGcLhubXbrVfbPuBF8OMwIOHhu9zke0ZK3ytzOd6+IzT4jlLgbJEUo73ideRfzswP+5rIWsyePVObtEHKJAbtGJKlulJ0yj1M13z0wkYKVGgxPTeUniTqUuArFuBhgE2x6EbSPLd8VtwLVvM4AEPESMghhmCPx5sLK9362Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759625611; c=relaxed/simple;
	bh=p6JIxoI4dT4LQW7tyXbLYkxz7afazfqimWbCeM5Rquw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZJ/upMFfcpnSjwoVa4VS6uijPP59M4JQdnQrz6/jfOBq/BLeCu5ajl9jC7q4w2g0WjkQktdYftGrVpseN134OBHepyuWEezYUojjy/ziT5/h3BQAYzpP71b/1Yogy6K1/54dN9LtmS0Jwk3/8VTEed7ySUm9VbgieNR59cQOsIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N65kl0JJ; arc=fail smtp.client-ip=40.107.200.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4MXLHZ+F/6RD1qu+QOYk6rBdAW3dNqEmkm+6ldArj4ICudVGi6BFRi2IUeO8yLId5FFdtGwfNnk/TJraCSMkR+3nfcILiPx7NpE+etEIvZfYX6umKHAQjobhtt2LeS9DpO31wig+Zjonn0oJ9m7jc43JpBhlWNIoe+L4umXNaoHbBw9hVJGrRp1BhwsB9pSytRYgDmjQkM68cUZUTpQOQ4pRAod5JMyhtPnrDE9jpXpQ4Au/zCAefZjZnu7YEV/lxO6BjkcN3uOnsnpJ1+XVkhfuUG2xAEOxcWQJ2DkJAMbtavSrNCBYxdwgQtfZkUk7ElADXxhdwSK1lNDGewA4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iyr3+fyNgTGnRRCM9BUuv/Dxmti0CPZo7VAJGCRs4bw=;
 b=WvqBmpmGO10orzUXTgapct661qjISHu08Tid6YX/LSjvKhexGafSao0rwZwQ4y5ThtlhoiRQxg1YQjPk8nE8FjgZwRoekYVT/60PGxxEhkdQPM/JZCtWAze6Fl6E6PxQDYX83ySc4ERrc4cmJRqo4mU4QP1BtRqrvBDQRDsF3pWMOm1ljvdZxtzrcV208EMpmd6iW8M5xWY1xqKoq5u7cj7iOPr2SDFoEmsJfLsIyBrPY6IH8+PFs5ro4tBhbkZ+XrYz9heE9Fs/Ey792uBrSB1nRJgj57OjrpMszav+uL7Wt5joc8p3WelhN1+J2HupoA1N8sEtQwjybJWd+ibyog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iyr3+fyNgTGnRRCM9BUuv/Dxmti0CPZo7VAJGCRs4bw=;
 b=N65kl0JJmtmJUmEo+MKUbjdfO0l/Umr6wjkDwWkL3Un38/aYNPZK8KnjWgo9eK2kJFROMqmaeahbHMOCMyrf4j18m3gArtI441l2VM8FyMo03lMUZGrNFBOVtxF8Z2AxalI4wYJ1a6CsXV3f8KR7ZnnOjbFAK2aSzC9950KBNI4PCfNOqp/qMun5FE4p7HT3Gtp3qgGtbi1WN83T+hMbH6+ZMY8pVP6z0IipcYz2jis+PzbWTJvLzGWfVAE0XEHo8uNlL+vrrmZj5BfdhAtP1g9jKZxPKx8MDndH1e85t94E/Mq7+NVZYa2jJtt2XZpXS1K7c5I6BHZ5PL7b1rUVHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SA5PPF9176ED2F1.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Sun, 5 Oct
 2025 00:53:21 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9182.015; Sun, 5 Oct 2025
 00:53:21 +0000
Message-ID: <600dc476-6922-4cd5-b3e3-ef10cd38085e@nvidia.com>
Date: Sat, 4 Oct 2025 17:53:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/29] arm_mpam: Probe the hardware features resctrl
 supports
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-14-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250910204309.20751-14-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0256.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::21) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SA5PPF9176ED2F1:EE_
X-MS-Office365-Filtering-Correlation-Id: 84953a07-05f5-4e17-36fe-08de03a99473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzRsUG9BVnVWQ3hvL1IwdGpEMSs1S3BoVzJBNEJXYjVTYmlYTytQSlZMNy9J?=
 =?utf-8?B?cHlueCtRanh5cTRieFYxV3Yxd1ZYZjN0K2Nub0JGMU9ZVjg3ZHEzM0Rra2pv?=
 =?utf-8?B?Z3N2OGpURWY3ekpySWU1bURDVmZkWW1NNU1MTlM0NlhWV0FPV1hNZnJKdk04?=
 =?utf-8?B?TnBRY2JTVmJjSVRORE1OR29hT25pMWRONnJuTVJsZ04wazI3NlRrbFVRYnlH?=
 =?utf-8?B?WWdUSnF3YTdGeG1jYkJNMWkzU1J2UVMweEY0N0RpeXBhZGtHWldzVTlRQlNr?=
 =?utf-8?B?aXE5R2x2b1l0K3pwQzNZWXUvTUVaMC9VUmk4N1QreGg3MElUbFlNbkZxZ2lQ?=
 =?utf-8?B?dDFoa3owdmdKb0JUeWNYMlR3OGxFcFlzT0NWZ2dFRkV3ZkJpUCs3dXFGbk9k?=
 =?utf-8?B?cGd3ZmwvL3VkNnVNL0tybUtWbU4zdFdyYWlEVmozbUFha2pJc2dIS0Fna241?=
 =?utf-8?B?c2c1OFpTcGI2ckFvM2xvOTFxTFRiaDFqQ0VvaENjNlJ4U1JQUnJDbVp2UnVU?=
 =?utf-8?B?NTJzZ2Y1ZkR4dXRGUmNPV2llckFPaElWV05SeXdaUzRUbGtVVkJEcU1wL3U2?=
 =?utf-8?B?ekg2WmZNRGNueWxHdndDdW9MM0lPa25qM1pHZzhZam4zNTRsVVVpZ2pLbDJU?=
 =?utf-8?B?Q1lDSmJuSloxcXNZTkx5NWk1WnNIa21hVXlUcmU1Y0hFVVBhOGJzbk5iUXVI?=
 =?utf-8?B?S2dQSk93dXRYeEhhcGxNWDNIZ2MvaHVmR3NjYm41bkNoQ3d5a0FHdjkramJa?=
 =?utf-8?B?aDlQN0tIa28zWjAyYUQzR25DQVI0TGJXMjA0bERVUWtvSjRvMmZCdmlyaGJO?=
 =?utf-8?B?cjUxcG9tTlhIbGJjK244cExONzk5bDlCdHFHM1h6SzFsZnhqMmYwVy9EdTB0?=
 =?utf-8?B?Rkp5Y1ZaMytIN0JlWllBWVFMQncvbVNjV2xkaWpWQWk4VUtvWnRIQnFwVTFZ?=
 =?utf-8?B?M2kzVTk0UmdzVWpONzB2Rk41SlVONFpOSE0wUkJaN0VwenlDcUNtM3dDUHlx?=
 =?utf-8?B?bm1VbXFLODZyVGRuZFZFbXBnU3ZqNVcrZzNsOXBkUWUrdzRZV1MwbTVFV3R1?=
 =?utf-8?B?YVo2Mm5HY3E4bHlURC8yN2lWNWNqNi9oK0J3U0JNdlR5OFYzSHpZajUxUWQ2?=
 =?utf-8?B?ZHdzWlYwcG9sdDFENytKQXNYWHBnRUk3WFlqSkN5OVdZVDROaW93czJTMVN2?=
 =?utf-8?B?WG95KzdFNEdxTm1lUUtDQjlEWjRYN3NmV2RVWjhIWGZtd3RGdDlhdnlXa3J4?=
 =?utf-8?B?aSsvUHdVUnpOU3E3QlArVTdCWFR3Ym0rWFBwUGdQOXpSTnNKUkhBQVB5OFNU?=
 =?utf-8?B?S3VjQ3NrS3VTaHBmalJ2REZlR2FrRVh5UTduMEQ3Wm5lTFViVWZyUDk0R0pG?=
 =?utf-8?B?U3plR1gzTS9QRnBVUFNsYm14RXMvNm5VdVBZM1RrRXF2bXJkZFZaaVVPLzNE?=
 =?utf-8?B?QTF0Wld1ZmZrNDU2eGtTL3hXQlN5MFNKazZxUnphdFk5MVdXd203R0tDajhw?=
 =?utf-8?B?SEVOOUhOZFZLSTM3VGJWSURiVlhVbVAzNE16c2o1ZHRSc3lwUUNkQ1BCV09R?=
 =?utf-8?B?OHgvZ3c5bFRSMkZUaEZTSFN4V1c0aWt1VmxIVE5ZWnFjYkpoT2JDR3pqRDYr?=
 =?utf-8?B?ak8zdmRPbkMvVGZhKzRaL2J5SXhVMEZsNHZPSGJjc2JsQnk2a1NzbkNoL2Vq?=
 =?utf-8?B?c28rSWViZXlDRUpSd2pYNE5yc1cza0xiSjFIRDhqM21sZUEybDRZRmJpRlJP?=
 =?utf-8?B?RjY1RzN1c1pYS1JmcUczWENhR1lBdUJMVFBsYzI4cXdtRzhDOThWdTVvQXBo?=
 =?utf-8?B?OGRQOUNiTExqSWNoeUZDSW5VTEJCZDM2dmxvTHlBa3N5cUZqcnIxVFo4cURJ?=
 =?utf-8?B?UXMvd1FZYXdhWDhXSDdCMldJR1pzS2FSVWJwb3A0bUphWnBGdE14bVNzWWp3?=
 =?utf-8?Q?Ks6aPZb9DVhJmC91Cack8VUJhtZCTHet?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDZ6Qy96RFJ2a2dNcnNTWHpVZkR2ekNPbkl2RGVPNVJTUDVsaVNnOTdVbjU3?=
 =?utf-8?B?enkzejdidGN4VHQ2c2IzOUlIdHZMYjk1YUNDQkVoNXRFVDZzUzFSRUtVNG1Q?=
 =?utf-8?B?Y2ozaENhSFMrVVQzSHdjeUl6ci9RRlg3MjNqUTVqcEI2SWpTTHBiSzRVNUFp?=
 =?utf-8?B?R2p4b3VmL1krQ3M1ZllXOEd5WVVWOUtDbWFpbFpiR2tFbjV3M0tWK21PcG85?=
 =?utf-8?B?SUJUcUsrdXZyMlZ3ZlNZM2pSWW9BSEtPbEIvMHc3TDI1eDRpMFU5cjBScnR4?=
 =?utf-8?B?TW1SSnJEVTFJeFBaWnNaeHBKcERGK2orVmpWaGMreXhoc24xbmtheEdld25v?=
 =?utf-8?B?bFZQV1JDMFZEa3RRZmtlRFFsY2VPQWhHNzQ5SkEzRDg2WERobkR0emo1SzBi?=
 =?utf-8?B?WVY1V0lXUnI2bHlkd2ZaZ3ErMHFWcC9OdDhCeGZOc3drUDBneTcrRUJLZXVZ?=
 =?utf-8?B?WlRjWFQveC96bStqekU3eWZCYmRFcVNiWTJrTWpJa2c4eWdJSVVoKzBUbEdq?=
 =?utf-8?B?ZHRJZ2ZQOFZ0cGoxMmhWZ2xjY3lJOE5kRmFSMlg0Q0JTZGxiRzA3VEp5Z1JD?=
 =?utf-8?B?RFpjUitYMVFRMGkwN1pybCtybmJkWjJsV3hYcTdpY2JLdjlidHR0c0laOEtw?=
 =?utf-8?B?bkF5WEU1eVlSblBFWWYzOWRWOU8wZUREaEpUbGxnTjhNakQzMklnZGhPbkZl?=
 =?utf-8?B?VVNqcWpLNm1kYVJxdE5GTlhuMElHcjh1TkVwdGhuQzl4NG80UjlZZHBvOElO?=
 =?utf-8?B?dHhOdWhJdVJJTkF4ajlTcnZOYmR3bjlwV293Y2ROdFU4U1JSa0VHZEpJTlc5?=
 =?utf-8?B?aXNzTHViY05JY2NxMXpIYjVLdHZnV1QxUlI5YUsvRVk5U3RLQVFvWFlZdUpC?=
 =?utf-8?B?R2h6dnRoRXV0ajBMZytQc1VUT2ZOUnlRM0xVa25mMURPcjdpZURNbFFLVVZp?=
 =?utf-8?B?Y3JjaDF5ZXRNNFZkZml6WHlJOEpHb3diNk82TEpCSjJjRWZGeCthcmpidkh4?=
 =?utf-8?B?aXZ6Zi9WNkxzQml6UDhESTR2N3NmS0ttaHUrUjc1YnpFVHhKVml4RkVmM0pP?=
 =?utf-8?B?YU40ZEhIZ3JFdFV0TUlhK0dJMXEvS1JxY0JNMDVHZkVPcmgrdDl3NTQvbi9Q?=
 =?utf-8?B?cUZYQTZkNlk0Yi9rRlREMWx3akdPV3k1QVVtTEJzM1ptSEpkTFFobEpmK2ly?=
 =?utf-8?B?RHg1amhTVUlyQWxmai9CSE1mN2x1SEl6SGllbXF1dDJkOTZHNVRoQ2l5aHJB?=
 =?utf-8?B?U3Z6QUFyNkdtVXEzU0QwdXVNMTlVdjlMY293bmtHN2RZOU85am1XZlpFTWF0?=
 =?utf-8?B?cldQem1ldHdFQ0ErUHA1c2E2Q0xvcXBLVFZOWDNCOWdPZmtTOHhoaDFVRnBp?=
 =?utf-8?B?QlZhd2tEK1NROEk2elFFMkorMlZoWnJuSDNRWk5jeXFDbnlseE9lVGUyUkdB?=
 =?utf-8?B?QWJWT2FOTmMvcUZFU0VBM1pVU3pFQzZwdWdUOWcxSFdaWnJGSHpvZTJxTWJM?=
 =?utf-8?B?MzJpQ2hBSjh6REExRW1lRDZWVlFMcE1GcFErUGNXK20xMDJvQW9aSllkWktz?=
 =?utf-8?B?WFFpeURPTml5RDEyUW5MeGd3YmIwOUdoQlhsMTBYQmVuYU9leUJyK2JRdk02?=
 =?utf-8?B?SHEzaVhjY1MySUpacWNVMkhleWN2U2FiYW8rYXlSNkVNNWZWaW5Ia0xRK2Zi?=
 =?utf-8?B?czVmUFhkYjlKL2t4Z2ZPZDF1RUVDWklRSTBwaHVnL29mZzNBcjRzRzdSRDkz?=
 =?utf-8?B?cHVzVUs4dno1UFBndVZHN0w4S2VMQ0Q5Qm5ESlQ0NGVXOURQdU1mWmZsaFNv?=
 =?utf-8?B?MnhhU3RDNFl4S3pxNC9IblJIZ25lWUhJT3lRemZLOForUUdlQkkwT3ZET0RW?=
 =?utf-8?B?eTREMk1CSjNUSFc3ZUVwRkdjb0g0SnY4QlE4SkIwV09zWXlGbkg1L3BYU3o3?=
 =?utf-8?B?RVV2TnVXamlEQzBNSmdsV3VyYjBtczlGdTNxQThoSDZMeThoa203bldBTmwz?=
 =?utf-8?B?OGlIdU1TNHZHaUtLUGlRcVB2UFVDWlM2bUtGT2xacTZxcS8zaGhNSU9OWi9X?=
 =?utf-8?B?NXd4ZVJBeTZ1dXJtWmduL3VNKytkb2U4SzBpWDFjNitEUXlTMjJNTENPWjVY?=
 =?utf-8?Q?mbtoQVgywBe0oGN7YHxgxWW73?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84953a07-05f5-4e17-36fe-08de03a99473
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2025 00:53:21.2312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2UgOziKq4gZzEQHChdPhU6zeY8wF3ybG++CpFurQSM4qZ9lMeHfnuM/zyOM8/uEd/oAWTn3ySlI8YTzWQv7dMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9176ED2F1


On 9/10/25 13:42, James Morse wrote:
> Expand the probing support with the control and monitor types
> we can use with resctrl.
>
> CC: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

A couple of minor comments below.

> ---
> Changes since v1:
>   * added an underscore to a variable name.
>
> Changes since RFC:
>   * Made mpam_ris_hw_probe_hw_nrdy() more in C.
>   * Added static assert on features bitmap size.
> ---
>   drivers/resctrl/mpam_devices.c  | 151 ++++++++++++++++++++++++++++++++
>   drivers/resctrl/mpam_internal.h |  53 +++++++++++
>   2 files changed, 204 insertions(+)
>
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index a26b012452e2..ba8e8839cdc4 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
[SNIP]
> @@ -592,6 +736,7 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>   	mutex_lock(&msc->part_sel_lock);
>   	idr = mpam_msc_read_idr(msc);
>   	mutex_unlock(&msc->part_sel_lock);
> +

Adding this blank line is irrelevant to this patch. It's better to move 
this blank line to the original patch #11.

>   	msc->ris_max = FIELD_GET(MPAMF_IDR_RIS_MAX, idr);
>   
>   	/* Use these values so partid/pmg always starts with a valid value */
> @@ -614,6 +759,12 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>   		mutex_unlock(&mpam_list_lock);
>   		if (IS_ERR(ris))
>   			return PTR_ERR(ris);
> +		ris->idr = idr;
> +
> +		mutex_lock(&msc->part_sel_lock);
> +		__mpam_part_sel(ris_idx, 0, msc);
> +		mpam_ris_hw_probe(ris);
> +		mutex_unlock(&msc->part_sel_lock);
>   	}
>   
>   	spin_lock(&partid_max_lock);
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 4cc44d4e21c4..5ae5d4eee8ec 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -112,6 +112,55 @@ static inline void mpam_mon_sel_lock_init(struct mpam_msc *msc)
>   	raw_spin_lock_init(&msc->_mon_sel_lock);
>   }
>   
> +/*
> + * When we compact the supported features, we don't care what they are.
> + * Storing them as a bitmap makes life easy.
> + */
> +typedef u16 mpam_features_t;
> +

mpam_features_t is changed to u32 later in patch #21. It's better to 
directly define it as u32 here and remove the type change in patch #21.

[SNIP]

Thanks.

-Fenghua


