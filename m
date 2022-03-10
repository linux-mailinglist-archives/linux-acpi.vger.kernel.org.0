Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382404D4E59
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 17:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241009AbiCJQO7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Mar 2022 11:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240772AbiCJQO6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2022 11:14:58 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2088.outbound.protection.outlook.com [40.107.212.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEB7187BAE;
        Thu, 10 Mar 2022 08:13:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5Coxa2tHOt878rBKaQixp9DqNAFy9/3Tx3Rpqnnb/ITO6zcHZAdmANcOzPU/xsmB3akoXl+fFzFyPHAMnlK7bBxja2/t0L5QB6htD/v5DBcE7mrq352Oe7hFhudesvBlI6rI4UOIr4npI3XmtTAqj4BIPERD4bwvCsX/pk5N/RdvndQKJUABhc/k3obmWZkuGetXxU9E2ZQyIB/B68D20UeNCLd5mE2PPndU8glGFe45Ji0TI2dQMuyoziKVUMW32crG1EdRjfKnxiNGevfvafMioElaJF1i6jvgp+CAr4p5T/WK4vqUVjM19HuL4/60g5JTtBHSZSwp3kNyYHBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hilwGjeAciv0k/OdYGrItoO7N1zfXcG/3q1iWbnXyF4=;
 b=XqsY8QzUbcieeYrlaL/bZKpp9caRDN+G6OIGxqU46bZg+vzgO2sBxlHNsVGPCaUey1+p1nHrYgyZ5OSQLjTLB42tqGPOkkPWyRlYfECzpYgXaJEPb7mvnmmlh1rPhvLDuICv9a7LxNmTw8s6vODU41pm1wbi7U1KfmPPuVy19B9xx+TUo0NY1+KCFFKCMhH1eK9UMUDaWD3Q03iGOZ9WHnocgP5UGDQ1dMkG6QvsV4eBfbq5g//7sekXls+0SVIN9u/aX5Wgn3lIhu+SOzfd3uDgANpGR8sztjNo7Dq+eGvAqM7aZ7wbIBqgP7CnayO7ac9LdFS+BTd/tO2j8S9jXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hilwGjeAciv0k/OdYGrItoO7N1zfXcG/3q1iWbnXyF4=;
 b=PhGRtM9MEUNbmIqZpfxVRXxtYhUckQYZHSFVVamHJxeIRWdVKcj6LmtUACFMSNwRy4SAZu6D0ajGlDcrny6k0VsLovDL8LLQVpyYBXmc7Z6NkPGy8AS6gKyXlAWNL2YGQ8RM6HcTYMNUPSuNxzSrbU/T3nhP76V/xUaRVMlyKIY=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by CH2PR12MB4972.namprd12.prod.outlook.com (2603:10b6:610:69::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 16:13:51 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 16:13:51 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH 1/4] ACPI / x86: Add support for LPS0 callback handler
Thread-Topic: [PATCH 1/4] ACPI / x86: Add support for LPS0 callback handler
Thread-Index: AQHYNJJ13YD+lX7dq0O8NxTdG9Aesay4xZMAgAAEpPA=
Date:   Thu, 10 Mar 2022 16:13:51 +0000
Message-ID: <BL1PR12MB51574A11A277225BFD404A35E20B9@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220310151705.577442-1-mario.limonciello@amd.com>
 <c7f595c16e0d15aea53eb1562c8a2f17705f4e09.camel@linux.intel.com>
In-Reply-To: <c7f595c16e0d15aea53eb1562c8a2f17705f4e09.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-10T16:13:19Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2821f054-be3d-4171-bc4b-7df75fbd6100;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-10T16:13:50Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 899d8faf-29c1-4ef8-be02-f72ee1b19d0e
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd94ecc6-a298-4363-9c3c-08da02b0f79b
x-ms-traffictypediagnostic: CH2PR12MB4972:EE_
x-microsoft-antispam-prvs: <CH2PR12MB4972E9EE88655D18AE3155B1E20B9@CH2PR12MB4972.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /seDOk2rCFOb7Cx2HLaW/t/aaReixSn9sXL6NqzUKIRYxDFkJUsjtjBgC40cio3bhiDNzE1sty7fx98rj7mabhRpha5DJBntDEZ3H/TN+UnivMSnljF7GUco/JnTEcOC/T+vKYJKetB3wdFz0T93Drm1ZzcsIzfGBxxnLgMSnDeHGTEIOMnZ+C+7TEkgI6fWqEzTHn/1CDMWyi1G1iqo5YexFvigJm/3SaJeMDiELu4K2pFbg4KoJCwEhinHhtRgn8WRrH1RHNXGXGftleluV8xdS+oO+Md9zEUXpGX5jQqoyd3va4nxKS3AOImTFn6wh7OUfmBmSB+JY33pgXSpSVSzbeGaEbMatWJBcC6673q84tdv3yH2yS48TM79/jIXScatichMSTlULvf7h9me81Uf1XXSy8Xbc8O+pTHLNMzFbzBmyeBiArx6jrtoZ56w0K5uuWoUg6e7YIZq7K9Y9NYdUtBM7XHB/sNyU0wW/MzsLHfO/W79+RkK78lsDMJc6qx4H5BFLrb5MlXLc81QzZPIE8DUhSJTnOlU6iKr2vkJG1LxIfAc/X+iIIIQDIVdeI58TmupLlL4BFeW0Wa/ejFvOWB8xcAB9B9QbZtkGMR3DLThBTJBpCvdZrtac5mJ4jd/sOf8/wHqHErclynOTdD8gJ1j6/jVBUAqCj2qv37QbXEj6TebEg8GQUZq0DUAl+Y//8eKp56H1xD0yeGRFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(64756008)(66476007)(66946007)(76116006)(2906002)(66556008)(66446008)(8676002)(38100700002)(4326008)(54906003)(52536014)(122000001)(71200400001)(8936002)(110136005)(38070700005)(5660300002)(55016003)(7696005)(45080400002)(508600001)(316002)(6506007)(33656002)(186003)(26005)(9686003)(83380400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2dwU01oRGFjdTduSys1STFqZVVKdGNqazhNMmYybHlxMW01RVRvZWJCOEJN?=
 =?utf-8?B?cklPdXZPcC85WnNpQi84YXU2OG1nQ0NnTVdWWjFxRXYvNmhOclBYTXQ5V0tl?=
 =?utf-8?B?akN1U1YvZGEwYUg2Rk9ROHo2M0U2cFZzUk43bUZGaG9QT00vaTdGbXQxUDNa?=
 =?utf-8?B?NG5vTklMSTAySWlZaHlmY0xMSm9yYkpqQ2hlbEZtVE9yS3Q0aGxwaXlLQ0Vk?=
 =?utf-8?B?M0lYdmdZTVZNbi9ZRW5vVUN3ODFXdVBzT2FtVmJOSkdxY002aUwxYlJWYmFB?=
 =?utf-8?B?OTNsVGhSSUR3a2VDTk9WVjU2aFhmZjkwTHRSeFI5akZPenJRRjc1OWJQWnNk?=
 =?utf-8?B?emJHYWEwdXhIZmlRRjZUaFBGdm1tcWh4VCtLVEpBaEhENVdHeEVYU0t6U1R5?=
 =?utf-8?B?bTJnQ2gva0lYdGVXK3hublR1Y0tyOC84MllwczBJM2pqQlJxZ1VNS0tuRUda?=
 =?utf-8?B?c20wNTAxeTg2YXFyUEdtd2cxaW1QM01NdnQ5ZTZWemRiVnBYL0Uwck1PaUpH?=
 =?utf-8?B?TjcyZlE1WmVxN2pqeWxnSTJ6amNHRGZHcmlqTUdoNE5RRW9kQ1ZEdUlHMEI1?=
 =?utf-8?B?RzE5VmdweTI0Wm9HRDN4QzI4bW1LYjJBbERsZUV5S01ZZ1dOQzJ1OCtDQU1N?=
 =?utf-8?B?ODYrd2xPK2ttWnUvbnZESWtkYVkvVXpsUUYvRTY1Uzh4RGt0OHhtbmZMZzJn?=
 =?utf-8?B?eFFtcDNBbXFFeVpjQkNDcHVheVUrVE1QaExkbUlQbDVLSnB6YWwweHdzN3p0?=
 =?utf-8?B?SG9PL3NndnlTMWdabU5maEk5R1VuVm8zRUZuV0FyUE9oS3hDR1Y5WS9TMFpk?=
 =?utf-8?B?UGo2eU1xQi85S1duQWJjMXRjdXVGSzQvTzZUSmNoRnZaSThzZlFhVFlMdXMz?=
 =?utf-8?B?VmRyczNQMnBZNUI2TFY5bHFRbjA3aW0ySWNsWCtwMEdOOVBsa0FWM1REMktI?=
 =?utf-8?B?aFFsOUd2V3pkK1AvalpaMGtaeWI4U092YytZM1NiRk5VR2NtVW8zanZrSjYz?=
 =?utf-8?B?UWtEbjBRL2pDN1c4NkxBRFBDbXMvOFdVNDIydDNqQWFmM0dmMDNwaVh6WUhJ?=
 =?utf-8?B?VWM2MmVkQVIwNnVqT2xkNTV4Z2RsMDNtSWFZeEtLWGRUSW9mQU8yRE0vTjF6?=
 =?utf-8?B?Y1NmbFRoc0oxSWp1VTRwcS90eHA3SUg4Q0tJZjUzY2ZndTREVUV1ZDI2bFQ5?=
 =?utf-8?B?eGdIZzJSbXZhWUtrVmNWamVMdGRJS1o0akp6MG9nOVNUVE11ZGtVRkdDbVlL?=
 =?utf-8?B?WTV0a251ay9rcXk4dTVNTmg5dmRmYXE3dVQ2SW53REdCa05XaEh4SDhBR3dH?=
 =?utf-8?B?VlNENElXNDd5bnczOTVWdm10dWtJQTg1U1M1RHpXZFVZeXpwQjRDOWFldTZU?=
 =?utf-8?B?UUNPRkxtdTJ6amVDbTFBTktQMy9oYTZVRWhSaEtOTWhTZ1QyWUxDN2pleG1C?=
 =?utf-8?B?ZmdPY3pmdEVQYjlwTDZOdU5RTWc1RWhSdmhyUXJ4QTJMeWtUU0phQjlwWS9u?=
 =?utf-8?B?MExILzlIb1Z1cmhGMUJRSHpMV0t5MnYrVDNnL1FRVmNuS1BTeUFQclNqMlJD?=
 =?utf-8?B?RzBJMFlodGV2cW1FWUZQVlcweDhHWmI2ajhxc0xsUFpkVC82NHVlVXp4SHho?=
 =?utf-8?B?LzBwU29zTi9mM2g5M2R2cVhBTm1ROWs5WEZwQXlCSVFMb3R0SnRFelFIeGp2?=
 =?utf-8?B?ZUhldS9aU0RnZENSdGh2aTdQelV1aUI2VW1HZU9tU0hkRE9OU2ZtSjB0RXkw?=
 =?utf-8?B?Sis3L2s4OVJaNzBUaWM2MlV3NmtpKytPdTFyNEhDbVlMdE1BU1FzWnJWWm9x?=
 =?utf-8?B?Y2VoMzFMWDJhdDJlWGd4YTNFSmxVM0owWjZjVlhZWE5tbEoxUzZBUTVxaDBw?=
 =?utf-8?B?RGlRdXBrY0JPQ3Z0UnFzS3NDdEozUTE2MU9uWG5CbVhBd00vN2xmWHU3MHIr?=
 =?utf-8?B?Ylo4NFZkejBRMnR0QzNrQ0FtSVdLSm5vcVVQZmdiQnFNS3Rnd1Bjc2duMk9K?=
 =?utf-8?B?VUZwcTFrZEZGb1dBcEJ1QnNhZmd3Y29xVjIzY2pvZDdNaG1qVi9hN0xoSWtW?=
 =?utf-8?B?SnlCRU1mbjJZQXg0eW5Cc2I0cDZFeXJ2b2dIdUFpaFVYbXdvQktCLzR2elNZ?=
 =?utf-8?B?bnR6alZzS292VDF2TEZFME53U0VXZ0ZIWk1GczdWOGZVZDhWTHljS3NFRmRU?=
 =?utf-8?Q?BnKxk/LDAT3DF6AoFWe3ww8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd94ecc6-a298-4363-9c3c-08da02b0f79b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 16:13:51.6923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5I2rxzh/3Hsnpu7VMRzQxv+ITBuj+yphtDSdMSDs1lOgXgb9BQZPCf11OTXMtU0wGkz5EEBd7ktFgWORlY0RLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4972
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W1B1YmxpY10NCg0KPiBPbiBUaHUsIDIwMjItMDMtMTAgYXQgMDk6MTcgLTA2MDAsIE1hcmlvIExp
bW9uY2llbGxvIHdyb3RlOg0KPiA+IEN1cnJlbnR5IHRoZSBsYXRlc3QgdGhpbmcgcnVuIGR1cmlu
ZyBhIHN1c3BlbmQgdG8gaWRsZSBhdHRlbXB0IGlzDQo+ID4gdGhlIExQUzAgYHByZXBhcmVfbGF0
ZWAgY2FsbGJhY2sgYW5kIHRoZSBlYXJsaWVzdCB0aGluZyBpcyB0aGUNCj4gPiBgcmVzdW1lX2Vh
cmx5YCBjYWxsYmFjay4NCj4gPg0KPiA+IFRoZXJlIGlzIGEgZGVzaXJlIGZvciB0aGUgYGFtZC1w
bWNgIGRyaXZlciB0byBzdXNwZW5kIGxhdGVyIGluIHRoZQ0KPiA+IHN1c3BlbmQgcHJvY2VzcyAo
aWRlYWxseSB0aGUgdmVyeSBsYXN0IHRoaW5nKSwgc28gY3JlYXRlIGEgY2FsbGJhY2sNCj4gPiB0
aGF0IGl0IG9yIGFueSBvdGhlciBkcml2ZXIgY2FuIGhvb2sgaW50byB0byBkbyB0aGlzLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxv
QGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvYWNwaS94ODYvczJpZGxlLmMgfCA3Ng0K
PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiAgaW5jbHVkZS9s
aW51eC9hY3BpLmggICAgICB8ICA5ICsrKystDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgODMgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2FjcGkveDg2L3MyaWRsZS5jIGIvZHJpdmVycy9hY3BpL3g4Ni9zMmlkbGUuYw0KPiA+IGluZGV4
IGFiYzA2ZTdmODlkOC4uNjUyZGMyZDc1NDU4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYWNw
aS94ODYvczJpZGxlLmMNCj4gPiArKysgYi9kcml2ZXJzL2FjcGkveDg2L3MyaWRsZS5jDQo+ID4g
QEAgLTg2LDYgKzg2LDE2IEBAIHN0cnVjdCBscGlfZGV2aWNlX2NvbnN0cmFpbnRfYW1kIHsNCj4g
PiAgCWludCBtaW5fZHN0YXRlOw0KPiA+ICB9Ow0KPiA+DQo+ID4gK3N0cnVjdCBscHMwX2NhbGxi
YWNrX2hhbmRsZXIgew0KPiA+ICsJc3RydWN0IGxpc3RfaGVhZCBsaXN0X25vZGU7DQo+ID4gKwlp
bnQgKCpwcmVwYXJlX2xhdGVfY2FsbGJhY2spKHZvaWQgKmNvbnRleHQpOw0KPiA+ICsJdm9pZCAo
KnJlc3RvcmVfZWFybHlfY2FsbGJhY2spKHZvaWQgKmNvbnRleHQpOw0KPiA+ICsJdm9pZCAqY29u
dGV4dDsNCj4gPiArfTsNCj4gDQo+IE1heWJlIHB1dCB0aGlzIGluIGFjcGkuaA0KDQpXb25kZXJm
dWwgc3VnZ2VzdGlvbiwgdGhhbmtzIQ0KSSdsbCBhZG9wdCB0aGlzIGZvciB2MiBhZnRlciBzb21l
IG90aGVyIGZlZWRiYWNrIGNvbWVzIGluIG9uIHRoZSBhcHByb2FjaC4NCg0KPiANCj4gLi4uDQo+
IA0KPiANCj4gPiArDQo+ID4gK3N0YXRpYyBMSVNUX0hFQUQobHBzMF9jYWxsYmFja19oYW5kbGVy
X2hlYWQpOw0KPiA+ICtzdGF0aWMgREVGSU5FX01VVEVYKGxwczBfY2FsbGJhY2tfaGFuZGxlcl9t
dXRleCk7DQo+ID4gKw0KPiA+ICBzdGF0aWMgc3RydWN0IGxwaV9jb25zdHJhaW50cyAqbHBpX2Nv
bnN0cmFpbnRzX3RhYmxlOw0KPiA+ICBzdGF0aWMgaW50IGxwaV9jb25zdHJhaW50c190YWJsZV9z
aXplOw0KPiA+ICBzdGF0aWMgaW50IHJldl9pZDsNCj4gPiBAQCAtNDQ0LDYgKzQ1NCw5IEBAIHN0
YXRpYyBzdHJ1Y3QgYWNwaV9zY2FuX2hhbmRsZXIgbHBzMF9oYW5kbGVyID0gew0KPiA+DQo+ID4g
IGludCBhY3BpX3MyaWRsZV9wcmVwYXJlX2xhdGUodm9pZCkNCj4gPiAgew0KPiA+ICsJc3RydWN0
IGxwczBfY2FsbGJhY2tfaGFuZGxlciAqaGFuZGxlcjsNCj4gPiArCWludCByYyA9IDA7DQo+ID4g
Kw0KPiA+ICAJaWYgKCFscHMwX2RldmljZV9oYW5kbGUgfHwgc2xlZXBfbm9fbHBzMCkNCj4gPiAg
CQlyZXR1cm4gMDsNCj4gPg0KPiA+IEBAIC00NzQsMTQgKzQ4NywzMSBAQCBpbnQgYWNwaV9zMmlk
bGVfcHJlcGFyZV9sYXRlKHZvaWQpDQo+ID4gIAkJYWNwaV9zbGVlcF9ydW5fbHBzMF9kc20oQUNQ
SV9MUFMwX01TX0VOVFJZLA0KPiA+ICAJCQkJbHBzMF9kc21fZnVuY19tYXNrX21pY3Jvc29mdCwN
Cj4gPiBscHMwX2RzbV9ndWlkX21pY3Jvc29mdCk7DQo+ID4gIAl9DQo+ID4gLQlyZXR1cm4gMDsN
Cj4gPiArDQo+ID4gKwltdXRleF9sb2NrKCZscHMwX2NhbGxiYWNrX2hhbmRsZXJfbXV0ZXgpOw0K
PiA+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeShoYW5kbGVyLCAmbHBzMF9jYWxsYmFja19oYW5kbGVy
X2hlYWQsDQo+IGxpc3Rfbm9kZSkgew0KPiA+ICsJCXJjID0gaGFuZGxlci0+cHJlcGFyZV9sYXRl
X2NhbGxiYWNrKGhhbmRsZXItPmNvbnRleHQpOw0KPiA+ICsJCWlmIChyYykNCj4gPiArCQkJZ290
byBvdXQ7DQo+ID4gKwl9DQo+ID4gK291dDoNCj4gPiArCW11dGV4X3VubG9jaygmbHBzMF9jYWxs
YmFja19oYW5kbGVyX211dGV4KTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gcmM7DQo+ID4gIH0NCj4g
Pg0KPiA+ICB2b2lkIGFjcGlfczJpZGxlX3Jlc3RvcmVfZWFybHkodm9pZCkNCj4gPiAgew0KPiA+
ICsJc3RydWN0IGxwczBfY2FsbGJhY2tfaGFuZGxlciAqaGFuZGxlcjsNCj4gPiArDQo+ID4gIAlp
ZiAoIWxwczBfZGV2aWNlX2hhbmRsZSB8fCBzbGVlcF9ub19scHMwKQ0KPiA+ICAJCXJldHVybjsN
Cj4gPg0KPiA+ICsJbXV0ZXhfbG9jaygmbHBzMF9jYWxsYmFja19oYW5kbGVyX211dGV4KTsNCj4g
PiArCWxpc3RfZm9yX2VhY2hfZW50cnkoaGFuZGxlciwgJmxwczBfY2FsbGJhY2tfaGFuZGxlcl9o
ZWFkLA0KPiBsaXN0X25vZGUpDQo+ID4gKwkJaGFuZGxlci0+cmVzdG9yZV9lYXJseV9jYWxsYmFj
ayhoYW5kbGVyLT5jb250ZXh0KTsNCj4gPiArCW11dGV4X3VubG9jaygmbHBzMF9jYWxsYmFja19o
YW5kbGVyX211dGV4KTsNCj4gPiArDQo+ID4gIAkvKiBNb2Rlcm4gc3RhbmRieSBleGl0ICovDQo+
ID4gIAlpZiAobHBzMF9kc21fZnVuY19tYXNrX21pY3Jvc29mdCA+IDApDQo+ID4gIAkJYWNwaV9z
bGVlcF9ydW5fbHBzMF9kc20oQUNQSV9MUFMwX01TX0VYSVQsDQo+ID4gQEAgLTUyNCw0ICs1NTQs
NDggQEAgdm9pZCBhY3BpX3MyaWRsZV9zZXR1cCh2b2lkKQ0KPiA+ICAJczJpZGxlX3NldF9vcHMo
JmFjcGlfczJpZGxlX29wc19scHMwKTsNCj4gPiAgfQ0KPiA+DQo+ID4gK2ludCBhY3BpX3JlZ2lz
dGVyX2xwczBfY2FsbGJhY2tzKGludCAoKnByZXBhcmVfbGF0ZSkodm9pZCAqY29udGV4dCksDQo+
ID4gKwkJCQkgdm9pZCAoKnJlc3RvcmVfZWFybHkpKHZvaWQgKmNvbnRleHQpLA0KPiA+ICsJCQkJ
IHZvaWQgKmNvbnRleHQpDQo+IA0KPiAuLi4gYW5kIGp1c3QgaGF2ZSAic3RydWN0IGxwczBfY2Fs
bGJhY2tfaGFuZGxlciAqaGFuZGxlciIgYmUgdGhlIGFyZ3VtZW50DQo+IGhlcmUuDQo+IA0KPiBE
YXZpZA0KPiANCj4gPiArew0KPiA+ICsJc3RydWN0IGxwczBfY2FsbGJhY2tfaGFuZGxlciAqaGFu
ZGxlcjsNCj4gPiArDQo+ID4gKwlpZiAoIWxwczBfZGV2aWNlX2hhbmRsZSB8fCBzbGVlcF9ub19s
cHMwKQ0KPiA+ICsJCXJldHVybiAtRU5PREVWOw0KPiA+ICsNCj4gPiArCWhhbmRsZXIgPSBrbWFs
bG9jKHNpemVvZigqaGFuZGxlciksIEdGUF9LRVJORUwpOw0KPiA+ICsJaWYgKCFoYW5kbGVyKQ0K
PiA+ICsJCXJldHVybiAtRU5PTUVNOw0KPiA+ICsJaGFuZGxlci0+cHJlcGFyZV9sYXRlX2NhbGxi
YWNrID0gcHJlcGFyZV9sYXRlOw0KPiA+ICsJaGFuZGxlci0+cmVzdG9yZV9lYXJseV9jYWxsYmFj
ayA9IHJlc3RvcmVfZWFybHk7DQo+ID4gKwloYW5kbGVyLT5jb250ZXh0ID0gY29udGV4dDsNCj4g
PiArDQo+ID4gKwltdXRleF9sb2NrKCZscHMwX2NhbGxiYWNrX2hhbmRsZXJfbXV0ZXgpOw0KPiA+
ICsJbGlzdF9hZGQoJmhhbmRsZXItPmxpc3Rfbm9kZSwgJmxwczBfY2FsbGJhY2tfaGFuZGxlcl9o
ZWFkKTsNCj4gPiArCW11dGV4X3VubG9jaygmbHBzMF9jYWxsYmFja19oYW5kbGVyX211dGV4KTsN
Cj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICtFWFBPUlRfU1lNQk9MX0dQTChh
Y3BpX3JlZ2lzdGVyX2xwczBfY2FsbGJhY2tzKTsNCj4gPiArDQo+ID4gK3ZvaWQgYWNwaV91bnJl
Z2lzdGVyX2xwczBfY2FsbGJhY2tzKGludCAoKnByZXBhcmVfbGF0ZSkodm9pZCAqY29udGV4dCks
DQo+ID4gKwkJCQkgICAgdm9pZCAoKnJlc3RvcmVfZWFybHkpKHZvaWQgKmNvbnRleHQpLA0KPiA+
ICsJCQkJICAgIHZvaWQgKmNvbnRleHQpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBscHMwX2NhbGxi
YWNrX2hhbmRsZXIgKmhhbmRsZXI7DQo+ID4gKw0KPiA+ICsJbXV0ZXhfbG9jaygmbHBzMF9jYWxs
YmFja19oYW5kbGVyX211dGV4KTsNCj4gPiArCWxpc3RfZm9yX2VhY2hfZW50cnkoaGFuZGxlciwg
JmxwczBfY2FsbGJhY2tfaGFuZGxlcl9oZWFkLA0KPiBsaXN0X25vZGUpIHsNCj4gPiArCQlpZiAo
aGFuZGxlci0+cHJlcGFyZV9sYXRlX2NhbGxiYWNrID09IHByZXBhcmVfbGF0ZSAmJg0KPiA+ICsJ
CSAgICBoYW5kbGVyLT5yZXN0b3JlX2Vhcmx5X2NhbGxiYWNrID09IHJlc3RvcmVfZWFybHkgJiYN
Cj4gPiArCQkgICAgaGFuZGxlci0+Y29udGV4dCA9PSBjb250ZXh0KSB7DQo+ID4gKwkJCWxpc3Rf
ZGVsKCZoYW5kbGVyLT5saXN0X25vZGUpOw0KPiA+ICsJCQlrZnJlZShoYW5kbGVyKTsNCj4gPiAr
CQkJYnJlYWs7DQo+ID4gKwkJfQ0KPiA+ICsJfQ0KPiA+ICsJbXV0ZXhfdW5sb2NrKCZscHMwX2Nh
bGxiYWNrX2hhbmRsZXJfbXV0ZXgpOw0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKGFj
cGlfdW5yZWdpc3Rlcl9scHMwX2NhbGxiYWNrcyk7DQo+ID4gKw0KPiA+ICAjZW5kaWYgLyogQ09O
RklHX1NVU1BFTkQgKi8NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9hY3BpLmggYi9p
bmNsdWRlL2xpbnV4L2FjcGkuaA0KPiA+IGluZGV4IDYyNzQ3NTg2NDhlMy4uY2FlMGZkZTMwOWYy
IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvYWNwaS5oDQo+ID4gKysrIGIvaW5jbHVk
ZS9saW51eC9hY3BpLmgNCj4gPiBAQCAtMTAyMyw3ICsxMDIzLDE0IEBAIHZvaWQgYWNwaV9vc19z
ZXRfcHJlcGFyZV9leHRlbmRlZF9zbGVlcChpbnQNCj4gKCpmdW5jKSh1OA0KPiA+IHNsZWVwX3N0
YXRlLA0KPiA+DQo+ID4gIGFjcGlfc3RhdHVzIGFjcGlfb3NfcHJlcGFyZV9leHRlbmRlZF9zbGVl
cCh1OCBzbGVlcF9zdGF0ZSwNCj4gPiAgCQkJCQkgICB1MzIgdmFsX2EsIHUzMiB2YWxfYik7DQo+
ID4gLQ0KPiA+ICsjaWZkZWYgQ09ORklHX1g4Ng0KPiA+ICtpbnQgYWNwaV9yZWdpc3Rlcl9scHMw
X2NhbGxiYWNrcyhpbnQgKCpwcmVwYXJlX2xhdGUpKHZvaWQgKmNvbnRleHQpLA0KPiA+ICsJCQkJ
IHZvaWQgKCpyZXN0b3JlX2Vhcmx5KSh2b2lkICpjb250ZXh0KSwNCj4gPiArCQkJCSB2b2lkICpj
b250ZXh0KTsNCj4gPiArdm9pZCBhY3BpX3VucmVnaXN0ZXJfbHBzMF9jYWxsYmFja3MoaW50ICgq
cHJlcGFyZV9sYXRlKSh2b2lkICpjb250ZXh0KSwNCj4gPiArCQkJCSAgICB2b2lkICgqcmVzdG9y
ZV9lYXJseSkodm9pZCAqY29udGV4dCksDQo+ID4gKwkJCQkgICAgdm9pZCAqY29udGV4dCk7DQo+
ID4gKyNlbmRpZiAvKiBDT05GSUdfWDg2ICovDQo+ID4gICNpZm5kZWYgQ09ORklHX0lBNjQNCj4g
PiAgdm9pZCBhcmNoX3Jlc2VydmVfbWVtX2FyZWEoYWNwaV9waHlzaWNhbF9hZGRyZXNzIGFkZHIs
IHNpemVfdCBzaXplKTsNCj4gPiAgI2Vsc2UNCg==
