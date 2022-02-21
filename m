Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89EB4BEA88
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Feb 2022 20:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiBUSoH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Feb 2022 13:44:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbiBUSme (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Feb 2022 13:42:34 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBEE10E8
        for <linux-acpi@vger.kernel.org>; Mon, 21 Feb 2022 10:42:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6SYMYLWxeN1rEWJDLBtL/uMlSRJbfp7NulOtXVJXOk2fveT8+CsNWblirZ4fsNHhwZeG9TyOFkrQCyxcvqEVEigS/L7UjZQAGJuXBVq6AZ90Em1ExuccXxuDa24F+oP6Y04qUTscptEVhhiVkpoDs/voqm3rdrN48CfWYxBQgLmsyQtIe3ycMIuZQebkbEBCU3C1Uez7Gn0gC4FHcDavJFq7Hf0x+QwMxAh5uvAZ5bnuSRrHkDCwE1CiI1mmvJpbxa3wTuVHS7tVYVTOUEQvfpnRICEjF1GGxGmY10ag2t+uz5xLjx3o9hy7AGpYADi8J1pDw4GVUCtOCtxEap+rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fky/qmj4MbWAIh6OJbgJ+6ZChdaELciLZnMNoN8cHns=;
 b=f0/LpVaPMqxWhh1nYoGtRME8fxFJA7tLJSRmBZbss+z3yQ+deDcN9lFlDQboaNjNTBLpCMZIh52RLg5wm4gllVzO79/Thz6aTDzhMDGknLDI+W0sKvTlobRUkHr6gY3gB/hRQXoOBbU0uyS76qUKH3NioFeFwuX/b2YBTqCHbY1reM35KV9JbTv3ypD67KU9IdExth3nENAzKfrSBGHjdgPRT7vupT0slMPRxT71VK13jB8vQlT588dEt4kLk7BSlxJ14Bz7uARAtcSkfGSk5+NOqsvCM8W2tCMQnqVszAhRcJHYM79qOTFgiKvD/7Tne1EpqzyVhh7fdAjYNwOpsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fky/qmj4MbWAIh6OJbgJ+6ZChdaELciLZnMNoN8cHns=;
 b=5gfmaHwnjkNT+mATbJ+mmJdrOoQNBAFbSf+O1SPFzbdqLhQPwBiIiroh75GIeEcZFcNC5plqFDhLsLTmvrRDJs8lSyVsD8Ynm2G2Qn0Es+uERIU2zMQKriy0XIATUbEOnt/nsvbx1u06jPdNfPH1TnuPH7n0dM+f3Msf5RNDwXs=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by CY4PR12MB1253.namprd12.prod.outlook.com (2603:10b6:903:3c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Mon, 21 Feb
 2022 18:42:02 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%4]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 18:42:02 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: Regression in 5.16-rc1 with suspend to idle
Thread-Topic: Regression in 5.16-rc1 with suspend to idle
Thread-Index: AdgjxKRqoif+H8GDSFuptXvIhGhWMAAJ0i2AAAqAH3AAMzUMAAAESZ8AABIh2uAAgBs6AAAFURlw
Date:   Mon, 21 Feb 2022 18:42:02 +0000
Message-ID: <BL1PR12MB51570F5BD05980A0DCA1F3F4E23A9@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <BL1PR12MB5157C5EA5510F0C9D7782AE8E2369@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0g81BmytcjgChXZumsHV5-byzSzDQbp2hc6CYzJ_6N=aw@mail.gmail.com>
 <BL1PR12MB5157E2CDD68BA585C5F4CF2BE2369@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0ho8PHGp0gAUp5KkUstTXLyUMsaQ7wTL=8xDJtjtXjPRw@mail.gmail.com>
 <CAJZ5v0j3Ma1HuUWoTmJvZDsUtm9hi84njJxJbBZMwe76eATSYQ@mail.gmail.com>
 <BL1PR12MB5157589AB3D9BC55C6D77EB4E2389@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0jmQaeSKj7wB1Jx+cxDHVxtHzbnTKZ4TcxnydHa5NOn+A@mail.gmail.com>
In-Reply-To: <CAJZ5v0jmQaeSKj7wB1Jx+cxDHVxtHzbnTKZ4TcxnydHa5NOn+A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-21T18:42:00Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=9922a9a6-a6da-4951-986f-5b5431de72e9;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-21T18:42:00Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: b4a037cb-46f3-494d-9a92-0033e7c3646f
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab6d724b-357e-43d4-737b-08d9f569d9e1
x-ms-traffictypediagnostic: CY4PR12MB1253:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1253FAB570D670559A7A2961E23A9@CY4PR12MB1253.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T3uzoPJJVKrELivlnh4aRsV6OeAPMzjUvSXMgT2YQdsCYgw2Q2DugJ7ykGYx5KKpAon2HmWB4BsWELD1pPOF97hNc641p4h3wyFtNsmYCDON6vDXc3u1h+ifanxb9gSLEjaQGAq3G7FY4H3+g+GbQj4vFvH7PQs53dxoXASKIN/0fhz4ZEwgsHPcsww4jk4hOFiLRZfJc9kUmzs11lOrAONrpcyHz1i431hq/xbDgs3NPYOTocU7y31bi/jF16m91CnkGpy2D6SpJ/E+PY6f8uSRAIo5le8AVlXm7GPKdBjV5WYaEy9u1GmFpNa93mibUfotZgWNzf3/tSAB15qHfZDR+OTvhsvd/tFCz1ymw1SNsH1kZp0lUHUdALUesqtPbgktDwCa/BLMRcZKNEa2Y18IcT55OJD30mxV3qHRbL+qtKrVMCxZ7qGGSWSMKI5iJqvlFk6qBgCK2Bshx5iLUkk9YpsuuICnvT9MFl7aB/HVdD97ivO1fGU4i5DtFpKGlX1g8MkqTkX6HrzQsjezgF8IfzOhMEsTeaFwEyR5RAOaW3jAAxyvIiAsIRlilcHF0heEDCIul5PVM8GyecuCM+FDv6FY7/3PGAA0oPlOsKPKgPMNF7S1TWdkcmw3Lqt5MH6U5ebxbeJznufmCAfdxBOcct9CCPd0w8Ov/inKqChy4lqDHnsci7/5Zq7ytHqE4cUBNYXe3IGp+U8k1AA+9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66446008)(64756008)(66946007)(8936002)(2906002)(66556008)(76116006)(52536014)(8676002)(4326008)(38070700005)(38100700002)(122000001)(33656002)(7696005)(9686003)(6506007)(508600001)(6916009)(55016003)(86362001)(316002)(15650500001)(5660300002)(71200400001)(186003)(26005)(83380400001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGN4UElYMW9RemVSRWNtWTBydkhXR1NtcHE0UXZ5MVoyUmJCZ0pTeUNRdi9z?=
 =?utf-8?B?SUpWckZOL3FWcmZidGxzaG1BeU94WWIvWWJKNjU4THBrVWtRWUhta2NCaHhE?=
 =?utf-8?B?QStSaEh4VEs1eFAyc1RxL0MrZTRFL290Wjl6djFvbDNKMTh3eHlsdjNxRnF1?=
 =?utf-8?B?WGZJdzhLVDNLZXFoOGFnSTBiZ2tXNkc3N0pCeksway9OZStWYUlMV3o3MC9k?=
 =?utf-8?B?UzBNWkNQZ1lULzRRYUVRUzFBRVNEVjBlRzFqT1JOOTlYL0FzNFdDbThYYlVR?=
 =?utf-8?B?ZHd2cktwSDY0SnJUTlgzRERscTlqUTUyZFlNdGZtekFlZEl0WFQrS3dLMmxP?=
 =?utf-8?B?ZUhobFBVa05HWE9NS0w4RGZSWlNjQUZUNnFZVmUycWFUdTYxQ1p0eUl2QXlY?=
 =?utf-8?B?TU1qclIvZXNzUlJFYlhFSnpob2VvSjFTa3BLZU5oUHRJZVV1eDRFUm9LREx1?=
 =?utf-8?B?RGlUMjRPOFN0QktEZkxzSEIxRmE4Q0xpTXdRLzB0YytEVm42ekFIYkVOQS9q?=
 =?utf-8?B?bGhUS1hGMkM2Q2ZNUjFmNHdVWEZQYURqUGhWZC9WRHBZNlJ6azFKdHg2eGtN?=
 =?utf-8?B?UUJtV3ppMUhZdXlHR1hEbjhXcFlIdHR0T1lKd1VLRS8vaVpnbWpVTjhLdVlN?=
 =?utf-8?B?cXdkSm1QbEg1emRQZ09sMEgyZGs4cDJibEorR2FJYXNJOUpmSURmUGNkT0x4?=
 =?utf-8?B?VkxHejRnc1dsTzhWSkJIeHJ5Zi9iTmprUmRtMG5PNk8rclk0aHBGVFVDd3kz?=
 =?utf-8?B?VTBqNldnMjhSSjAzSkZxV3h3Q2g0cWtCTGVYQm9rOG96dG9qUzVzYitFV00y?=
 =?utf-8?B?aG1Zc01rbTBEeXNQcmZSOFk3ZjdXRkFBQ1pEeWhyOGtvMUFsVU9VMGsrY0oz?=
 =?utf-8?B?dDBBMnJaNjNPRG1pb0gvV0MxS3NsRDdJR0pJUHlUdWlWNHFvbTdna1hJMGxB?=
 =?utf-8?B?NXJSaGZKOUpXQzNDd2t5VkNqVGtrUEY5czdPWTN6WW5aYlhkWEVhaHRyd2h5?=
 =?utf-8?B?WGt2UExSY3F6Tzd5cVhsTEp1QnZBN1UzMjJTYVRaR0FVVXdYdWYvR0kyOVFl?=
 =?utf-8?B?cU1IN2VlWlY1WlRzS29hbnZOWENFc3FtNG9PTGl4bTdBTUV5MTNkM3lHOGxH?=
 =?utf-8?B?alcrUjZwa1FQRk9zQ0Y5UE82TE5RZzhGb2xOSTJPU0ZxUTYvRUZiZUpZZ0ZC?=
 =?utf-8?B?SHQ5cDNIMzNvbjBVdDMyWTU1VW1wMW9mZjVTR29JVElYY05ZSXQ3MVF5LzR0?=
 =?utf-8?B?cGt6YWJXYUdJRmNzV09sdlNNNmVkSEZPWnUzSmdWWVdmS01kU3l2T05wZlc0?=
 =?utf-8?B?Vk5yRjFBRG84OC9aQ1N0NFdQZ0FvcHI2czF6SjdJb1lRdmlhYXFROXhoc3pR?=
 =?utf-8?B?WURzZVJWT0dYR0t4RFErUFdEU0NFVFVWQkc4bXZyVFV1UjdEK0lna052NUY0?=
 =?utf-8?B?TXlXNXJiUTNucGFPaWYrUDc2VEE5bFIrQzVYVUNsc1NUQS9DbmJXMVBjRjAr?=
 =?utf-8?B?TXJXOW9iODVyZE5WdmJNS2NQSWg5SVVESWMxWnh4ejA3S3hISWR4bFBOVFMz?=
 =?utf-8?B?cmdZOUhWTVhRZkJibWVBZUdjUnpaWFFKN3dWMVQrb2JwRTAwRkFIc2JjRnpH?=
 =?utf-8?B?Uk03U2NNOE13eUlsZXlxRGhpRi9lLzluL0NyREg1SndVaGorVWZ4c3d4YStS?=
 =?utf-8?B?WTFXbHpSM2ZobUhTa2N5b0VyRkV5NHkySEtUZ21SOVlmcE1DVUVZVlBQeGV6?=
 =?utf-8?B?dDVQeUpvbWJLR3R3Qm5PQyt0aldVT1kwV241R1dBZVA0Uyt1WmNjaTZOYW01?=
 =?utf-8?B?QUZpeGh0Uk1VOEZFNC9NWVQ4VlJad0VMVlJYSFBpcHd3ZUhlNFBqd04zR29L?=
 =?utf-8?B?azBCT2hWMXpNTDFVR1BNMXprUEVJaWQwUTdOeFV5elMxbDFaRS9xUk9nNXlV?=
 =?utf-8?B?TjZhTi9JdVhsL2ZQV0FKL2QvTExIM002azV2cDNNdjVPRWd1Qk9mUHU5cGRB?=
 =?utf-8?B?bUd3c2UvbVREVHRtOFBjckl0NlF2K3VzckNHQ1VZN05SMU1EcnpWVGRhcVJj?=
 =?utf-8?B?WFpCM1M2UWJZNVowckpadFZTeGp0cGhacVc1aDRhMWJUVzhCNzVjT2NaT2JS?=
 =?utf-8?B?T2prSFV5T0prai8wL3J6ME56YVBNalJQcUxYTkVLck11dk1kYUFGRGVabXBo?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6d724b-357e-43d4-737b-08d9f569d9e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 18:42:02.4500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LFTEEx95nALc8zl0jvonYqKF+HHAXw6Tensshm0wcCp2tqFbatm8W4Q3U5N00xDOaNT2P85s8FNcPyN33zCTmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1253
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KPiA+ID4gQXR0YWNoZWQgaXMgYW5vdGhlciBwYXRj
aCB0byB0cnksIHRlc3RpbmcgdGhlIGh5cG90aGVzaXMgdGhhdCB0aGUNCj4gPiA+IG9ic2VydmVk
IGNyYXNoIGlzIHJlbGF0ZWQgdG8gQ1BVcyBiZWluZyBpbiBpZGxlIHN0YXRlIHRoYXQgYXJlIHRv
bw0KPiA+ID4gZGVlcCBmb3Igc29tZSByZWFzb24gZHVyaW5nIGxhdGUgc3VzcGVuZCBhbmQgZWFy
bHkgcmVzdW1lLg0KPiA+DQo+ID4gSSB0cmllZCAzIHRlc3Qga2VybmVsczoNCj4gPiAqIDUuMTct
cmM0ICsgWW91ciBzZWNvbmQgZGVidWdnaW5nIHBhdGNoDQo+ID4gKiA1LjE3LXJjNCsgWW91ciBm
aXJzdCBkZWJ1Z2dpbmcgcGF0Y2gNCj4gPiAqIDUuMTctcmM0ICsgQSBoYWNrIEkgd3JvdGUgdGhh
dCBwdXNoZWQgYW1kLXBtYyBpbnRvICJsYXRlciIgaW4gdGhlDQo+IHN1c3BlbmQNCj4gPiB1c2lu
ZyBhIGdsb2JhbCBzeW1ib2wgY2FsbGVkIGFmdGVyIExQUzAgaW5zdGVhZCBvZiBsZXR0aW5nIGl0
IHJ1biBpbiBub2lycSBzdGFnZQ0KPiA+DQo+ID4gSXQgd29ya3MgcHJvcGVybHkgb24gYWxsIG9m
IHRob3NlLCB0cmllZCBhYm91dCA1eCB0aW1lIGluIGVhY2guDQo+ID4NCj4gPiBUaGVuIEkgY29u
ZmlybWVkIEkgY291bGQgc3RpbGwgY3Jhc2ggaXQgb24gNS4xNy1yYzQgd2l0aCBteSBjb250cm9s
IGtlcm5lbC4NCj4gDQo+IEkgd291bGQgZG8gc29tZXRoaW5nIGxpa2UgdGhlIGF0dGFjaGVkIHBh
dGNoLCB0aGVuIChwcm92aWRlZCB0aGF0IGl0IHdvcmtzKS4NCg0KSSBnb3QgYSB2YXJpYXRpb24g
b2YgdGhpcyB0byB3b3JrLiAgTGV0IG1lIGNsZWFuIGl0IHVwIHNvbWUsIGRvIHNvbWUgbW9yZSB0
ZXN0aW5nIGFuZCBJJ2xsIHNlbmQNCml0IG91dCB0byByZXZpZXcuDQoNCkxvbmcgdGVybSAtIGFy
ZSB5b3Ugb3Bwb3NlZCB0byBkcml2ZXJzL2FjcGkveDg2L3MyaWRsZS5jIG1vdmluZyB0byBkcml2
ZXJzL3BsYXRmb3JtL3g4Ni8/DQpJJ2QgcmVhbGx5IGxpa2UgdGhlIHN0dWZmIGFtZC1wbWMgZG9l
cyB0byBiZSBhIGNhbGxiYWNrIGFmdGVyIGxwczAgKHdoaWNoIGlzIGNsb3NlciB0byBob3cgaXQg
d29ya3MNCm9uIFdpbmRvd3MgLSBpdCdzIHRoZSB2ZXJ5IGxhc3QgdGhpbmcpLg0KDQpJIGZlZWwg
bGlrZSBrZWVwaW5nIHRoZSBzdHVmZiBpdCBkb2VzIGFzIG5vaXJxIGlzIGdlbmVyYWxseSBmcmFn
aWxlLCBhbmQgSSB3YW50IHRvIGF2b2lkIHRoaXMga2luZA0Kb2YgYnJlYWthZ2UuDQo=
