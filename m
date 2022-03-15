Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCA24DA409
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Mar 2022 21:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351730AbiCOUdr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Mar 2022 16:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241887AbiCOUdr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Mar 2022 16:33:47 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA9C53B59
        for <linux-acpi@vger.kernel.org>; Tue, 15 Mar 2022 13:32:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3gyr0MZsm4iL48elUJtifpvNU+J1cqlWxeog/gwKhQm8Bh+SpdBrk8fwRpjK8oCBEJ4cKaytfym1MyK0r6xg4o5Rjc1Av8Tpf6P2ZCr4Jn19aitsabEeqx+YgSrwwLKa9+AVpZ0sMp0ZiitBiiQkrnG6Z8s5KdszfYdvIXtb3YZqpoae+jBpyIQzMriTwU9u3AUENgphwz2aGwcWzURsHc+1m9Z51NutXOEIrlhb17oUxM3wjSrhPWGFPjjiDiVFRE79Cf2qAMLZMsmiqXGoB60nH8D3A9Nj7KleCocjHh9t4pBpkyDmEaCbTAcnemT6siMsCHLzi19PW+4e/3AwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbGH8wIVP/nB13Ln6nti2lhIZN5Oqrwn9s/KoFCkUOk=;
 b=nUcGcT0c9p4DR4Si56JuLHE7zBLkyVNpU2514hPfzJPYBIPiFTz3Ir+RV/0H0U21Kv71XZOA5Ai/pos91oTmxY4g0reyUwy2nxe+bGQ/ovevAfayYIfpBTHxfolz4imOXl2xkcMKin1iEOR40YVnihptBemlZf1rYYRPUimd3HGrnay4VXOBkE+Z1oLc9NVt3nLOjigHXm7pJATpJvcFQS7IUWW9puN+JvITiSC0y8+pgVmw5xghqjZ6BW3ITrcy+mnS/SCw5tSxCuKzuGkGyWjJO+q/5BOeAU5kZuas4qnjLZlmatqREXUcS049jhaPh+zW0HCRsgCMbjVqTWZv7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbGH8wIVP/nB13Ln6nti2lhIZN5Oqrwn9s/KoFCkUOk=;
 b=XJpQLdVtMrzbPkAneYSiyuDIGCdmWgrXYOyzCafE1wwyoO4i/CIpgy2wkRVSk55oAkQrxiXIXDQvdfiWoazpQSVB2oF+FbM88F3n8nJdXb6t3tHR4QJdJyAw/LQyPq7IVUituXjIQoUA0Y9yaZkToNM8hB2COYcoar25hsvkrkc=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by PH7PR12MB5925.namprd12.prod.outlook.com (2603:10b6:510:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 20:32:32 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 20:32:31 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>,
        "Liu, Aaron" <Aaron.Liu@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: RE: [PATCH v6] ACPI: bus: For platform OSC negotiate capabilities
Thread-Topic: [PATCH v6] ACPI: bus: For platform OSC negotiate capabilities
Thread-Index: AQHYNMYH7nSloADYlk2nIR9Xb+AhIay6UkUAgAOsBiCAAVS4gIAAjdlQgABmN4CAAKB/AIAABd5Q
Date:   Tue, 15 Mar 2022 20:32:31 +0000
Message-ID: <BL1PR12MB515702B2DB9FED265B7B41BAE2109@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220310212805.3786-1-mario.limonciello@amd.com>
 <CAJZ5v0ibnaZZu_Gxngjbu5vzdQaJog8XZnJP6_msLqV_gi4Zig@mail.gmail.com>
 <BL1PR12MB5157839B59321A1A6AD9F73FE20E9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0g_TH+OeQkBwXELKZiRcxjLvstr8G_bXOBChJ94sTkvHw@mail.gmail.com>
 <BL1PR12MB51576398DFBD0EADC6AFEAF1E2109@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0i=ecAksq0TV+iLVObm-=fUfdqPABzzkgm9K6KxO1ZCcg@mail.gmail.com>
 <CAJZ5v0iStA0JmO0H3z+VgQsVuQONVjKPpw0F5HKfiq=Gb6B5yw@mail.gmail.com>
In-Reply-To: <CAJZ5v0iStA0JmO0H3z+VgQsVuQONVjKPpw0F5HKfiq=Gb6B5yw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-15T20:32:29Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=87dccce7-b0eb-45df-816c-6874c0daf3d1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-15T20:32:30Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 5b64e273-1042-4391-afe3-14e8aa57934e
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 541266bb-bea9-4da0-a841-08da06c2ee5c
x-ms-traffictypediagnostic: PH7PR12MB5925:EE_
x-microsoft-antispam-prvs: <PH7PR12MB5925CC0E16A9DC8A7D0768ACE2109@PH7PR12MB5925.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mX8yFq3CEMjg9u9UhqXUOKL6sZ9RreEzTxcu/HjGhS0x1BQgQGdfMG7V8S0KXP66I5UL7dZtinXlfsdkrFwY2ekn+U1s4pIWZjo+MmbYjCl9gnEIMSHNtO2YgKEdbgnGG22tOhXZwVq9iq6jrLAZ/o0V/XBleX6gX7ur6ITJUUwSuWl/hZ2mOhQ9YPgVlIWCfpcaYm2w+o4VBWEmBpbJW/jYHnJMu85aee90qAPCaO4dK426a6+E7gE1X+88Ehsy4NGN12EofNPg2Nh3rLFhjdr3M1nwZH9mwGEryqyM+nJkNvNVAnh/av4No+LpOgQJmgkIAR6TUcDDfE3bD5Vp/yV44p3INTm95PIUD/scob4pXaBGCs23DD+VTixQbmmbFpQWc0dLUVCzDqUjzguP7hlRwAXgpZtjXLoRqKJI1vMtvzQWUAB+MMu+OPEsy51BcOgG1R2pg4gBvrkXWvaP7N1qBApk4fQKm9H//0MN0qyRBe5F4/txthuzR0TKbLma0Y+rCiPnQ5h0vFmRjRBpD9JnCeIL55Zb6wDJoGq67hOm4XvkxEvnvvgVaqCFNLBPgMxx4BsE+RE5wTZMMQk5tOcdEWgQt5vH8BsWdhAU8uCobjN3a1xxBz1SBnh5qPd2FhfKQ3Z+24tvOd+kLqP/zFzPjqVsi0x/70XjKOpL0VZdMVKiS/Ght0CyhlhTJ7TdCKrCXLtPyEwjjei0fHYh2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(38070700005)(66946007)(6916009)(76116006)(66446008)(66476007)(64756008)(6506007)(7696005)(71200400001)(54906003)(9686003)(316002)(508600001)(86362001)(186003)(8936002)(83380400001)(38100700002)(5660300002)(2906002)(122000001)(33656002)(4326008)(8676002)(55016003)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUlKZTBrdm84ZGlZbjZXVy9ESG9nNWc5Uzhxd3V1RmJucmNYWklJN1lFOXhN?=
 =?utf-8?B?b3BHZ1d6amNQRy9qUTZhZW5jQXVrcTBtTjFTcVhQTzE1eG95V1QxcXl1YzBC?=
 =?utf-8?B?WktHWFpDYms0S2ZkaDV4QmsrejZYL1ZlT200SENZWTdKTHk3Y2xmNE9sRFpa?=
 =?utf-8?B?TjJWVTNLdjVtMEh4VCttbDlvZ1NCNWswbFpNNithZGljZ0d4cTZjN0MycTU1?=
 =?utf-8?B?R29zQVFmRnN6VjZxYjY0dHBoai9PU0Z4bVlTWFRScTJtbjJOVmk0MTdXS04x?=
 =?utf-8?B?TS95RjZhYmRiaEM4UkpkeXVHNUc0NTlZK0NlaURlYzVESmZxeDBOcGNnSENa?=
 =?utf-8?B?VmM4NTF1VHNHYkd1YmRhaHFXMTAwOVBoOUk5TTA4QnpQYjhJL2dmQU50MmdS?=
 =?utf-8?B?WEh4Ujl2K2d1dXBTS1NCWkJXWUorQ0hpTlErV2hPNTgxWFgza1F1ZTZYSjdo?=
 =?utf-8?B?K1NMMlFZbng3bTRodFU3TysvOHgxd3FRYnFKdm9hNDBqdi8raGJjL2E5cGxv?=
 =?utf-8?B?Tmx2TFQyekk4V09maFMyNlNyU0syOE12WlQ0VDJYcUxYWlQ1YXdNRHhmeHRt?=
 =?utf-8?B?b2FKbXh6TWNydUNyZExMQ295MUlsWGdOK3JxN2NkUkhFaWh5SU1DYmtDeEJo?=
 =?utf-8?B?eDBQaXoxYmR4OXNNS2M3elFKNXBXc3N5dmxVN3ZIQStOLzZHVndvWGJvVmhn?=
 =?utf-8?B?eTl2bHZVNHRLeUgyaWx0d203a3ExeU1KZlFYTHZyN0V0OTF6WENMelF0cTZT?=
 =?utf-8?B?Ulo5RFdZV0lhYUZOMVFJaUM3bGxSV0JBZ2R6SG5EbzZ2L3RBcTBmak5WbWFj?=
 =?utf-8?B?R3hDMWtMR0RWZEpnLzc1QXB1b0tJRlVLbzZ4Y0FrRy8yUk5hVnNFbllBL2dE?=
 =?utf-8?B?VjdZSHN3TEtPbDJGaGM0Z0dhTFdjVkhIMUR1cHJoQ3JhUTZleTgxNCtzckw1?=
 =?utf-8?B?ajZWUC81ckR3QlFMM1NreGZTNktoSk05a0pxNEJFQzlXWHpBdzFRc2NjTysz?=
 =?utf-8?B?alhNOHJrYXYwcnRoS2o3SjhCZlJpS0dHZzlhZ2U1TEgwTnlnZWhvaCtBQU55?=
 =?utf-8?B?NHh6aWQ0OTZFOWRueTd1bm5STnNaQk5SaGhWcWYvejFEcHJRUHR5elJtaE1K?=
 =?utf-8?B?QVFwK25vT0dZem95b3VSdFFxcndYa3EycDFkKzVBb200VUxyaTFQSUlQOWtZ?=
 =?utf-8?B?cmlUSXJuQ2kybmdnVEJMK3NQR1k3UFQvUWJSTUZDYnJ5MGhPYkw5dC9vYkR5?=
 =?utf-8?B?dDkzU09rZ0FUMjRYRXlXakVobWNuWWY1UTR0WThiK1E1S3BRS29uZzJ2MDJn?=
 =?utf-8?B?RUVUQWltcVFsV1Y2bVYzMmNMOVh5cjlGRFNFeWt5dG9BdThNbi9vc2N2YzdK?=
 =?utf-8?B?UlZNaGVNeGJuM2NtL2QvenVkbUZHT0RuOHdoVVhnRGV0RHFNclhzY2VvR2p0?=
 =?utf-8?B?ZGk2eFM0U3RpTFViN2srY3BqdG5LZTg4VGo0ZVFnUDluUUFjcFhJSnh2d0Nr?=
 =?utf-8?B?dVRVdEdacjVyZHB0YU5pb0pCM1BSZGM5amdvWmh4RGxkQUc5NkNnM05rcm1Y?=
 =?utf-8?B?T0Jub2NyRSsvSVl2a3BJVnphcWlmclo0Vzlnc2hsdGxTL01veXJPeDkvMCta?=
 =?utf-8?B?V0ErQWQ3VERhMzJvOUJnSnlYR3J0cm9oNjJMdjhNSVlieXBOMnFDa0lpank1?=
 =?utf-8?B?NzBldHorUWc1VHNib0pOOWJ4Q3pkVm1RMG9lOWF2Q0dCcERROUczTDFMblhk?=
 =?utf-8?B?UWc4WXd4TkNWaU1uNTlMeklpZHovdlVGZjIvTFNkUUl0UWdjbzlhb1BMdWZx?=
 =?utf-8?B?M1BhOU5TTmFCRFpjSVkxdmpCcitTMEFIRjd0cUhiby9oRzQzcnZlcXh3eCsr?=
 =?utf-8?B?SkJZRWtZb2pCTEYvSGhPN0ErVm10UFplZ0c2L0RVVnlwZ21hV0U5ZDFVVm1n?=
 =?utf-8?B?UllPN3NUWUpoazBZZEdkWEVSODRrVWwrSXJvNFcrMXd4UlE3aklmUmZWMFh3?=
 =?utf-8?B?NEVVejVQbDNyeloxL296ZStCUlc3NHVCajZqVmNDU1pwUzQwODBUTnExVG9P?=
 =?utf-8?Q?dv8ljI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 541266bb-bea9-4da0-a841-08da06c2ee5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 20:32:31.7568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zOd2vZ3IF5yogVq56KkThUUAWWSmhtgbn3TqCE1Dq1IDsVkf1cvVKJBq6EvKQHMhSNIOp6kGyH117AhWAzmn6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5925
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W1B1YmxpY10NCg0KPiA+ID4gPiBUaGF0IGxhdHRlciBwaWVjZSBhcHBlYXJzIHRvIGJlIHRoZSBi
dWcgaW4gcXVlc3Rpb24gaGVyZSBhbmQgSU1PDQo+ID4gPiA+IGZpeGluZyBpdCBkb2Vzbid0IGV2
ZW4gcmVxdWlyZSBjYWxsaW5nIGFjcGlfcnVuX29zYygpIHdpdGggdGhlIHF1ZXJ5DQo+ID4gPiA+
IGZsYWcgc2V0IGZvciBtdWx0aXBsZSB0aW1lcy4NCj4gPiA+DQo+ID4gPiBJIHRoaW5rIGp1c3Qg
dGFraW5nIHRoZSByZXN1bHRzIHdpbGwgcmUtaW50cm9kdWNlIHRoZSBDUEMgYnVnIHRob3VnaA0K
PiA+ID4gd29uJ3QgaXQ/ICBTbyBob3cgdG8gYXZvaWQgaXQgYnV0IGFsc28gdG8gdGFrZSB0aGUg
cmVzdWx0cz8NCj4gPg0KPiA+IEkgdGhpbmsgdGhhdCB0aGUgT1Mgc2hvdWxkIG5vdCBhc2sgZm9y
IHRoZSBjb250cm9sIG9mIHRoZSBDUFBDIGJpdHMgaWYNCj4gPiB0aGV5IGFyZSBtYXNrZWQgYnkg
dGhlIGZpcm13YXJlIGFuZCBpdCBzaG91bGQgYXZvaWQgaW52b2tpbmcgX0NQQw0KPiA+IHRoZW4u
DQo+ID4NCj4gPiBPdGhlcndpc2Ugd2UgcmlzayBicmVha2luZyBsZWdpdGltYXRlIGNhc2VzIGlu
IHdoaWNoIHRoZSBmaXJtd2FyZQ0KPiA+IGFjdHVhbGx5IGRvZXNuJ3Qgd2FudCB0aGUgT1MgdG8g
Y29udHJvbCB0aG9zZSBiaXRzLg0KPiANCj4gSSdtIGJhc2ljYWxseSB0YWxraW5nIGFib3V0IHJl
dmVydGluZyBjb21taXQgMTU5ZDhjMjc0ZmQ5LCBhcyB0aGUgcGFydA0KPiBvZiB0aGUgX09TQyBk
ZWZpbml0aW9uIGluIHRoZSBzcGVjIGl0IGlzIGJhc2VkIG9uIGFwcGVhcnMgdG8gYmUgYm9ndXMN
Cj4gKHRoYXQgd2lsbCBiZSBhZGRyZXNzZWQgc2VwYXJhdGVseSB2aWEgdGhlIEFDUEkgc3BlYyBw
cm9jZXNzKSwgYW5kDQo+IGFwcGx5aW5nIHRoZSBhdHRhY2hlZCBjaGFuZ2Ugb24gdG9wIG9mIHRo
YXQuDQo+IA0KPiBJZiB0aGlzIGxvb2tzIGdvb2QgdG8geW91LCBJJ2xsIHRha2UgY2FyZSBvZiBp
dC4NCg0KWWVzLCB0aGF0IGxvb2tzIGdyZWF0IGFuZCBJIGNoZWNrZWQgd2l0aCAxNTlkOGMyNzRm
ZDkgcmV2ZXJ0ZWQgYW5kIHRoYXQgYXBwbHlpbmcNCnRoZSBwcm9ibGVtIGRvZXMgbm90IGV4aXN0
LiAgSSBkbyB0aGluayBpdCBoYXMgdGhlIHBvc3NpYmlsaXR5IHRvIGNhdXNlIENQUEMgdG8gbm90
DQpiZSBlbmFibGVkIG91dHNpZGUgb2YgSW50ZWwgdGhvdWdoIHNpbmNlIEhXUCBpcyBvbmx5IHNl
dCB0aGVyZSBzbyBJIHdvdWxkIHN1Z2dlc3QNCnRoaXMgb3RoZXIgY2hhbmdlIG9uIHRvcCBvZiBp
dDoNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9idXMuYyBiL2RyaXZlcnMvYWNwaS9idXMu
Yw0KaW5kZXggNGRmNzQ5YjgyNTY4Li5lNjFkYmQ3ZjcxMDggMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2FjcGkvYnVzLmMNCisrKyBiL2RyaXZlcnMvYWNwaS9idXMuYw0KQEAgLTMxNCwxMCArMzE0LDgg
QEAgc3RhdGljIHZvaWQgYWNwaV9idXNfb3NjX25lZ290aWF0ZV9wbGF0Zm9ybV9jb250cm9sKHZv
aWQpDQogI2VuZGlmDQogI2lmZGVmIENPTkZJR19YODYNCiAgICAgICAgY2FwYnVmW09TQ19TVVBQ
T1JUX0RXT1JEXSB8PSBPU0NfU0JfR0VORVJJQ19JTklUSUFUT1JfU1VQUE9SVDsNCi0gICAgICAg
aWYgKGJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9IV1ApKSB7DQotICAgICAgICAgICAgICAgY2Fw
YnVmW09TQ19TVVBQT1JUX0RXT1JEXSB8PSBPU0NfU0JfQ1BDX1NVUFBPUlQ7DQotICAgICAgICAg
ICAgICAgY2FwYnVmW09TQ19TVVBQT1JUX0RXT1JEXSB8PSBPU0NfU0JfQ1BDVjJfU1VQUE9SVDsN
Ci0gICAgICAgfQ0KKyAgICAgICBjYXBidWZbT1NDX1NVUFBPUlRfRFdPUkRdIHw9IE9TQ19TQl9D
UENfU1VQUE9SVDsNCisgICAgICAgY2FwYnVmW09TQ19TVVBQT1JUX0RXT1JEXSB8PSBPU0NfU0Jf
Q1BDVjJfU1VQUE9SVDsNCiAjZW5kaWYNCg0KICAgICAgICBpZiAoSVNfRU5BQkxFRChDT05GSUdf
U0NIRURfTUNfUFJJTykpDQo=
