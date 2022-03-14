Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C75E4D8A8A
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Mar 2022 18:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbiCNRLZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Mar 2022 13:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiCNRLY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Mar 2022 13:11:24 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D4D3DDF6;
        Mon, 14 Mar 2022 10:10:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gk2eWrx5FgP1IZ5vwc57i7NIkYmgwTcz1sw8gzPD6OoVyfx223U5MOFgdSIMJhFk3evxt5Kjw03o2XQQfKcgFbRRtH2BYPCyQiuluq+rKbQ82MnwSL1NoaO4+RzyBofUPctc81I16ZArxWnj585lCdIeyKFc9SPHfyvJrAfZlvoMMFiEmIwuqZllysxQMNbbhNv5EfIF/phQZFrEheTVFRd6RQa2TbEGRs6GTzf83gAz8wl+K9qW9UvB+aQmrl0I3qBLytCNfSq/YyH0vmGmNBdrjzYnpeJBBgPDtnpvwfe2j/0AMt3UYJU4m7dPHzNYmie4zFTfYUg8ix/kyJQkHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k11XT9pUAZJXbCJ3JTkoLT8T71Fi/rEQfldwvHiv5fI=;
 b=VNfWFMk1LNS8XeJkja8AgMU3sae0I/pAn9rNrmYXRiGuGRZ85D+OJkcaayUtNP8KQCtMOHU32gksvoL0ak6N4e6TQHEjMInj6ZW9L3b8XFSm9GLnvWOz/ExkZYYhiQfOWo+2+yzvFVIwglRxc/5Y5qWf5R0I+783o4MP7wYmLVWMWc8DHPLuRs+Z0RBBRKTmkLSlIE+Nv6CI1LypHbITCpgzMaX6WzBn1FWFiEoE/Z38ssvXZKvFiBwpAq4vqSnC+oGo3kHL0UN5OtrUEZe2+cxQNmcPIVoNiq093v1Ds9947XOtoLKEg78+pa7dnWdoxIpirxSmbEC2e68v31ZHSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k11XT9pUAZJXbCJ3JTkoLT8T71Fi/rEQfldwvHiv5fI=;
 b=Ci2rFh+R3hQmpag2wRuOMry1pZWQ9J9UTkzZXGvcu8FgWQ7epK0UJh50Wq+xa6JIIY6lQI36eJKPG+h/EV3wmPq+DfcdVyPoYf+EfmTESvmlcljX2NnPo2sMDfVcuAuTBAcLWGwd7e4ukydd3f0rslqTptZKJc/PDyLqevTUHpk=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by MN2PR12MB3855.namprd12.prod.outlook.com (2603:10b6:208:167::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Mon, 14 Mar
 2022 17:10:10 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 17:10:10 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <markpearson@lenovo.com>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
Subject: RE: [External] Re: [RFC] ACPI: platform-profile: support for AC vs DC
 modes
Thread-Topic: [External] Re: [RFC] ACPI: platform-profile: support for AC vs
 DC modes
Thread-Index: AQHYMvpOgF/dWfErcUSFT4Dgm8wHfqy1kShQgAAH2ACAAAKsEIAADIOAgAAaOICACRpdgIAADaMggAATYYCAAA1OAIAAAFKAgAAXcYCAAACS4A==
Date:   Mon, 14 Mar 2022 17:10:10 +0000
Message-ID: <BL1PR12MB5157271E2D482A066F9912A2E20F9@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <markpearson@lenovo.com>
 <20220301201554.4417-1-markpearson@lenovo.com>
 <65d8cf3b-0eea-0583-fa23-e2c71287fb85@redhat.com>
 <BL1PR12MB5157CDB77675859B7F279578E2099@BL1PR12MB5157.namprd12.prod.outlook.com>
 <7b281a37-5163-6cd7-360e-1c63bde714a8@redhat.com>
 <BL1PR12MB5157125246817A70649C12F7E2099@BL1PR12MB5157.namprd12.prod.outlook.com>
 <1cd4ae24-ae92-302e-ac87-76ef15472a9f@redhat.com>
 <2180533b-c921-5ae4-e6bc-569728a4f990@lenovo.com>
 <c18abb55-6874-6e1e-bdb0-9d96d52987cd@redhat.com>
 <BL1PR12MB5157C14DE5F521D4B5C08366E20F9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <c16ea8ba-5944-0384-4bc3-d5438fe5e1f7@redhat.com>
 <78fc0363-2ae6-bd75-ecfb-606ce411c79a@redhat.com>
 <49205849-4239-3558-f377-797e7561848e@lenovo.com>
 <f0d069d0-40c7-b875-0f24-d3a89451d272@redhat.com>
In-Reply-To: <f0d069d0-40c7-b875-0f24-d3a89451d272@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-14T16:58:18Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6a9aa8df-5ae4-4cb7-8d62-5f1e72ed6127;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-14T17:10:09Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: a867267f-d493-4baf-b096-d5aae1854a25
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4d33794-415d-4ce0-1ac6-08da05dd7f45
x-ms-traffictypediagnostic: MN2PR12MB3855:EE_
x-microsoft-antispam-prvs: <MN2PR12MB38558FF7C530E0B90ABC3D74E20F9@MN2PR12MB3855.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qpIxtJ4gRiU50rZg4YO185iNJ0gGvnpVGL7bOzb1EHDgQThHgVOfmYMPdPrLfTymOGU623zxddZB5IImuqlMLpgn3QuzpkOP2kfC+cVe+gUM7qNBoOrrBOfQwVZe0VSQtl57OHY8dRcfrdTR76ne0gm5BQbUvf6Yl/rpv2ep/CDyESWjvyUVRK/sEdjJD3DlLs0tN4s6X9Mrh/LkKFKeJbowBJzOfn8Kd12Wm39pW718TPv+RHDIbOaYETi6FkH7/TPx42ZmCRHcHDg+kabJ46fkOkoIDFcgp2Wqu073DFfYNSQAwnMteEK42Wj+KDBicj+ZYaW50a+KEFIAxyIjIxCdI8CfnoaoZHL7J6JEJT2q8EfarPtBB9grVVMdV20r7fQ6PdvNKmLoAgHQ3LLPuySdg7aPKUPk7RK35aztOX+leKbprH3ZF/6bXFxsIfC45uxfIiV7uywi20yKgqEBpEg7vel94c5agvWcQKs4bPC6RvV3bhBs2Tkiu4Td7Ry4XWlhkB7xdWClsXEVJcsr3ktQVIKmz8eX7gcbDXHef8PEs+ufipQjJ0C2Xr+xmyKQdhEgzOf+7Oz5cIqhL8RDVkQPVxAl1SwNV3ke4NpwFEPLkLXOXMIFz58BnRdesnQkmkKDX7hoqj5fzmFQybeMG7nCYtQzpJVUNHsufB816smu7CyIjBq0uM2GpbELv+xIrTOykRFPYffRXL/Vk17acA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(110136005)(316002)(33656002)(76116006)(66946007)(508600001)(38070700005)(71200400001)(8936002)(66476007)(52536014)(5660300002)(2906002)(55016003)(38100700002)(8676002)(64756008)(66446008)(4326008)(66556008)(122000001)(86362001)(26005)(9686003)(6506007)(7696005)(83380400001)(186003)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3JwVW9tS0tZMzVjQ0hHQW5Lc2pseTlCMDhkMGQ4VUJqdjhCOWRmOEZheXgz?=
 =?utf-8?B?L2lWanVFZTExTnN6Qm8ydHlaMGpheFl0NTRLMkxva3BIN01ER1NzK2U3bnB6?=
 =?utf-8?B?aU95RkRJMS9wTUFTbi9SOUhRckRVak84UXA1QjBXOWtuRlVJMkI1YnV1dW5U?=
 =?utf-8?B?c2dFK2QrSUpteXJuZXFBLytCdndmU3NydDRubU5XcHNUbUE3YXA2dUlNUG9v?=
 =?utf-8?B?OWd2S0drT1QyaU8wZGhlTDlpMXlkWUIvVXI1cnptd1FaQm1Nelgzb2VIbHVV?=
 =?utf-8?B?azhWSTNLU3UzVlZKS3dNa2w3QUUyODBpYzZOMVhJY1ZYMnUwd3crNEY1UVVP?=
 =?utf-8?B?L29ybEJhbGlWWXZmRmY4WkJOV0lpTWt5a2RubEovZG9iekxERmdDZTQwaHhz?=
 =?utf-8?B?WnVVbk5PZjA1VC9lbEZXd0l5ZmMxcFlrRWZMSHhmVWZpVXI0cXdsaWxBWUln?=
 =?utf-8?B?RW15SmRhRHhZOHNSa1BFSkdaWWxLN1NYTGpIRUxINVhwc0RmbHFJY0Zxc0VO?=
 =?utf-8?B?U2V4dzI4TXNPVlc1c1JRZW5WM3lubTNnOVpZaEZmYUF2UlVLcTl5YkxhOWc0?=
 =?utf-8?B?Z3dTSEVmWTF2dDJVZHJubTRaTzQzU0syTjkrcFhwcVZZaGxteTdLSU1xK3pP?=
 =?utf-8?B?RU1leVJjYkFvdE9GZXhEbjNZd3VxNVc2L21ieUhjK25WZnRCY2t2a0xWQVNr?=
 =?utf-8?B?YXU3WHJFVElrazdXWDF1ek9FT0R5UDFhemxzQ0t4NFl1TUsyWnhvS1lpWEpX?=
 =?utf-8?B?cFRqZm5KMTQ2SlJObEJDTjgwTHI5NVBoTFpLem9HTkswcHc1ZlJWbTg4QTBo?=
 =?utf-8?B?Y3l0aUdkWlFBcFByMjBVWDNkNHpOb1RLRjV2ZU1YM2owQUVvQXRxRTdVdCtO?=
 =?utf-8?B?VFRmTC9jRldOeTdUQUdqWk1ITUoxZjVCbU83K3ZPcWx5ZEcreTlaQXppWTZV?=
 =?utf-8?B?WG50UjNkc0RjcHdwZ0ZoS0lmaW05a0JiUFVFc2lTaEVjeCt5M3g1VWNJeTVL?=
 =?utf-8?B?cVhGSFQybmxrdFpEc1prK0ErbTdhUmlScklWR2ljWU9BYlNiWHFtQXRKVDJB?=
 =?utf-8?B?NzBQZUZDTzZzMkF2TitZVCszL1NVZlErQmdtME1XNXlkdGZteE1LTWVQNWtI?=
 =?utf-8?B?ejJERnZJS05LZkZ3RklGOHF4YnBTeFpKVlJKaE9nV1lNdlZNT05xZkdUTU9v?=
 =?utf-8?B?Sm9HdFpESk9MY2NldmJmc2dUUlg1Rm4yd3JHN2JHa1Nzcmg4RVlkZWIwYlBF?=
 =?utf-8?B?VndDY3NOM1JBd2MvUkZCOFV3WWVvU0RrRVRjQXk0WlU3R1BGSmplWlR3VzhO?=
 =?utf-8?B?NnJHRUZyZjA4ektPekhKVk16TVpuSG5HR2JVcWZndUg3OXJ5cGJUNzZFYTJO?=
 =?utf-8?B?MVI0cEhPall6RzF6SklvSzhlWTBFSW02YlRhWXJiK0d0OElqK1Y0QTcrMjFt?=
 =?utf-8?B?cUVEZUJ1SU9rVkRjSXhmSUlvNURIWkNwL0RKbUVoQ1dzb2ZJK0RYd1Awb09q?=
 =?utf-8?B?MXZMQU5PQlYyUVc3NkZYK0VLZVlzY3FDbXZpZkY2bnpXa1N5M21ZN05lVkNs?=
 =?utf-8?B?TUtPdW91YVZMWVoxdXZ3SDBMZ053Z0c4Tk1HVlg5MnIreVZ0M2NRTXgwUERD?=
 =?utf-8?B?RStmNnhqSEJSTTRETE9MR2d4L1JZOWx5L0dDd3VicmlGdlE1NUVseGZrdGJk?=
 =?utf-8?B?NVVkYmQ3L0libGY0RWhDM2Jmbkg1MEw4cmxGMGNPTzUybStHUEw5TnBXR3Y2?=
 =?utf-8?B?TXB4dTZpK3VGNXo2cGhzOFUzaHBaQXBPK1NFc3Zrc3RwY3BqNHQ4QW0xM1NK?=
 =?utf-8?B?TVlIZVlzREprWVY5ZXQ5cHNwMk1hU3NJUWRzME83K3BIM0NOL21TS2tDVm5h?=
 =?utf-8?B?SnNhdk9lR2ZJOWlXQWNHc1R1OG9mbzNwVFNuaXE1WVJqKytUN21pbk5BYWtD?=
 =?utf-8?Q?48cAQfPvR7HcANzXFpfw27a8G5mmz+i6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d33794-415d-4ce0-1ac6-08da05dd7f45
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 17:10:10.7024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EQetyEtOd9YpDxXhlUahDo1zs+vjNwMAQi3V174V0lzFgxzSf50vSUPgKjJdGuXL4dSj0inAXA+4nSQSdMmHuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3855
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W1B1YmxpY10NCg0KK1NoeWFtDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4NCj4gU2VudDogTW9uZGF5LCBN
YXJjaCAxNCwgMjAyMiAxMTo1Ng0KPiBUbzogTWFyayBQZWFyc29uIDxtYXJrcGVhcnNvbkBsZW5v
dm8uY29tPjsgTGltb25jaWVsbG8sIE1hcmlvDQo+IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29t
Pg0KPiBDYzogcmFmYWVsQGtlcm5lbC5vcmc7IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOyBw
bGF0Zm9ybS1kcml2ZXItDQo+IHg4NkB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtF
eHRlcm5hbF0gUmU6IFtSRkNdIEFDUEk6IHBsYXRmb3JtLXByb2ZpbGU6IHN1cHBvcnQgZm9yIEFD
IHZzIERDDQo+IG1vZGVzDQo+IA0KPiBIaSwNCj4gDQo+IE9uIDMvMTQvMjIgMTY6MzIsIE1hcmsg
UGVhcnNvbiB3cm90ZToNCj4gPg0KPiA+DQo+ID4gT24gMjAyMi0wMy0xNCAxMTozMSwgSGFucyBk
ZSBHb2VkZSB3cm90ZToNCj4gPj4gSGksDQo+ID4+DQo+ID4+IE9uIDMvMTQvMjIgMTU6NDMsIEhh
bnMgZGUgR29lZGUgd3JvdGU6DQo+ID4+PiBIaSBNYXJpbywNCj4gPj4+DQo+ID4+PiBPbiAzLzE0
LzIyIDE0OjM5LCBMaW1vbmNpZWxsbywgTWFyaW8gd3JvdGU6DQo+ID4+Pj4gW1B1YmxpY10NCj4g
Pj4+Pg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IEkgY3ljbGVkIHRocm91Z2ggYSBmZXcgZGlmZmVyZW50
IGltcGxlbWVudGF0aW9ucyBidXQgY2FtZSBkb3duIG9uDQo+IHdoYXQgSQ0KPiA+Pj4+Pj4gcHJv
cG9zZWQuIEkgY29uc2lkZXJlZCA2IHZhbHVlcyAtIGJ1dCBJIGRvbid0IHRoaW5rIHRoYXQgbWFr
ZXMgc2Vuc2UgYW5kDQo+ID4+Pj4+PiBtYWtlcyBpdCBvdmVyYWxsIG1vcmUgY29tcGxpY2F0ZWQg
dGhhbiBpdCBuZWVkcyB0byBiZSBhbmQgbGVzcyBmbGV4aWJsZS4NCj4gPj4+Pj4NCj4gPj4+Pj4g
QWgsIHNvIHRvIGJlIGNsZWFyLCBteSAyIHNjZW5hcmlvcyBhYm92ZSB3ZXJlIHRoZW9yZXRpY2Fs
IHNjZW5hcmlvcywNCj4gPj4+Pj4gYmVjYXVzZSBJJ20gd29uZGVyaW5nIGhvdyB0aGUgZmlybXdh
cmUgQVBJIGhlcmUgYWN0dWFsbHkgbG9va3MgbGlrZSwNCj4gPj4+Pj4gc29tZXRoaW5nIHdoaWNo
IHNvIGZhciBpcyBub3QgcmVhbGx5IGNsZWFyIHRvIG1lLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBXaGVu
IHlvdSBzYXkgdGhhdCB5b3UgY29uc2lkZXJlZCB1c2luZyA2IHZhbHVlcywgdGhlbiBJIGd1ZXNz
IHRoYXQNCj4gPj4+Pj4gdGhlIGZpcm13YXJlIEFQSSBhY3R1YWxseSBvZmZlcnMgNiB2YWx1ZXMg
d2hpY2ggd2UgY2FuIHdyaXRlIHRvIGEgc2luZ2xlDQo+IHNsb3Q6DQo+ID4+Pj4+IGFjLWxvdy1w
b3dlcixkYy1sb3dwb3dlcixhYy1iYWxhbmNlZCxkYy1iYWxhbmNlZCxhYy0NCj4gcGVyZm9ybWFu
Y2UsZGMtDQo+ID4+Pj4+IHBlcmZvcm1hbmNlDQo+ID4+Pj4+DQo+ID4+Pj4+ID8NCj4gPj4+Pj4N
Cj4gPj4+Pj4gQnV0IHRoYXQgaXMgbm90IHdoYXQgdGhlIFJGQyBwYXRjaCB0aGF0IHN0YXJ0ZWQg
dGhpcyB0aHJlYWQgc2hvd3MgYXQgYWxsLA0KPiA+Pj4+PiB0aGUgQVBJIHRvIHRoZSBkcml2ZXIg
aXMgdG90YWxseSB1bmNoYW5nZWQgYW5kIGRvZXMgbm90IGdldCBwYXNzZWQNCj4gPj4+Pj4gYW55
IGluZm8gb24gYWMvZGMgc2VsZWN0aW9uID8gIFNvIGl0IHNlZW1zIHRvIG1lIHRoYXQgdGhlIEFD
UEkgQVBJIExpbnV4DQo+ID4+Pj4+IHVzZXMgZm9yIHRoaXMgd3JpdGVzIG9ubHkgMSBvZiAzIHZh
bHVlcyB0byBhIHNpbmdsZSBzbG90IGFuZCB0aGUgRUMNCj4gYXV0b21hdGljYWxseQ0KPiA+Pj4+
PiBzd2l0Y2hlcyBiZXR3ZWVuIHNheSBhYy1iYWxhbmNlZCBhbmQgZGMtYmFsYW5jZWQgaW50ZXJu
YWxseS4NCj4gPj4+Pj4NCj4gPj4+Pj4gSU9XIHRoZXJlIHJlYWxseSBiZWluZyAyIGRpZmZlcmVu
dGx5IHR1bmVkIGJhbGFuY2UtcHJvZmlsZXMgaXMgbm90IHZpc2libGUgdG8NCj4gPj4+Pj4gdGhl
IE9TIGF0IGFsbCwgdGhpcyBpcyBoYW5kbGVkIGludGVybmFsbHkgaW5zaWRlIHRoZSBFQywgY29y
cmVjdCA/DQo+ID4+Pj4+DQo+ID4+Pj4NCj4gPj4+PiBObyAtIG9uIExlbm92bydzIHBsYXRmb3Jt
IHRoZXJlIGFyZSA2IGRpZmZlcmVudCBwcm9maWxlcyB0aGF0IGNhbiBiZQ0KPiBzZWxlY3RlZA0K
PiA+Pj4+IGZyb20gdGhlIGtlcm5lbCBkcml2ZXIuICAzIGFyZSBpbnRlbmRlZCBmb3IgdXNlIG9u
IGJhdHRlcnksIDMgYXJlIGludGVuZGVkDQo+IGZvcg0KPiA+Pj4+IHVzZSBvbiBBQy4NCj4gPj4+
DQo+ID4+PiBBaCwgSSBhbHJlYWR5IGdvdCB0aGF0IGZlZWxpbmcgZnJvbSB0aGUgcmVzdCBvZiB0
aGUgdGhyZWFkLCBzbyBJIHJlcmVhZA0KPiA+Pj4gTWFyaydzIFJGQyBhZ2FpbiBiZWZvcmUgcG9z
dGluZyBteSByZXBseSB0b2RheSBhbmQgdGhlIFJGQyBsb29rZWQgbGlrZQ0KPiA+Pj4gdGhlIHNh
bWUgMyBwcm9maWxlcyB3ZXJlIGJlaW5nIHNldCBhbmQgdGhlIG9ubHkgZnVuY3Rpb25hbGl0eSBh
ZGRlZA0KPiA+Pj4gd2FzIGF1dG8gcHJvZmlsZSBzd2l0Y2hpbmcgd2hlbiBjaGFuZ2luZyBiZXR3
ZWVuIEFDL2JhdHRlcnkuDQo+ID4+Pg0KPiA+Pj4gVGhhbmsgeW91IGZvciBjbGFyaWZ5aW5nIHRo
aXMuIEhhdmluZyA2IGRpZmZlcmVudCBzdG9yaWVzDQo+ID4+PiBpbmRlZWQgaXMgYSB2ZXJ5IGRp
ZmZlcmVudCBzdG9yeS4NCj4gPj4+DQo+ID4+Pj4+IE90aGVyd2lzZSBJIHdvdWxkIGV4cGVjdCB0
aGUga2VybmVsIGludGVybmFsIGRyaXZlciBBUEkgdG8gYWxzbyBjaGFuZ2UgYW5kDQo+ID4+Pj4+
IHRvIGFsc28gc2VlIGEgbWF0Y2hpbmcgdGhpbmtwYWRfYWNwaSBwYXRjaCBpbiB0aGUgUkZDIHNl
cmllcz8NCj4gPj4+Pg0KPiA+Pj4+IFRoZSBpZGVhIEkgc2VlIGZyb20gTWFyaydzIHRocmVhZCB3
YXMgdG8gc2VuZCBvdXQgUkZDIGNoYW5nZSBmb3IgdGhlDQo+IHBsYXRmb3JtIHByb2ZpbGUNCj4g
Pj4+PiBhbmQgYmFzZWQgb24gdGhlIGRpcmVjdGlvbiB0cnkgdG8gaW1wbGVtZW50IHRoZSB0aGlu
a3BhZC1hY3BpIGNoYW5nZSBhZnRlcg0KPiB0aGF0Lg0KPiA+Pj4+DQo+ID4+Pj4gQmVjYXVzZSBv
ZiB0aGUgY29uZnVzaW9uIEBNYXJrIEkgdGhpbmsgeW91IHNob3VsZCBzZW5kIG91dCBhbiBSRkMg
djINCj4gd2l0aCB0aGlua3BhZCBhY3BpDQo+ID4+Pj4gbW9kZWxlZCBvbiB0b3Agb2YgdGhpcyB0
aGUgd2F5IHRoYXQgeW91IHdhbnQuDQo+ID4+Pg0KPiA+Pj4gSSBmdWxseSBhZ3JlZSBhbmQgc2lu
Y2UgeW91IGludHJvZHVjZSB0aGUgY29uY2VwdCBvZiBiZWluZyBvbiBBQy9iYXR0ZXJ5IHRvDQo+
IHRoZQ0KPiA+Pj4gZHJpdmVycy9hY3BpL3BsYXRmb3JtX3Byb2ZpbGUuYyBjcGRlLCBwbGVhc2Ug
Y2hhbmdlIHRoZQ0KPiA+Pj4gcHJvZmlsZV9zZXQgYW5kIHByb2ZpbGVfZ2V0IGZ1bmN0aW9uIHBy
b3RvdHlwZXMgaW4gc3RydWN0DQo+IHBsYXRmb3JtX3Byb2ZpbGVfaGFuZGxlcg0KPiA+Pj4gdG8g
YWxzbyB0YWtlIGEgImJvb2wgb25fYmF0dGVyeSIgZXh0cmEgYXJndW1lbnQgYW5kIHVzZSB0aGF0
IGluIHRoZQ0KPiB0aGlua3BhZA0KPiA+Pj4gZHJpdmVyIHRvIHNlbGVjdCBlaXRoZXIgdGhlIGFj
IG9yIHRoZSBiYXR0ZXJ5IHR1bmVkDQo+IGxvdy9iYWxhbmNlZC9wZXJmb3JtYW5jZQ0KPiA+Pj4g
cHJvZmlsZS4NCj4gPj4+DQo+ID4+PiBBbmQgcGxlYXNlIGFsc28gaW5jbHVkZSBhbiB1cGRhdGUg
dG8gRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy0NCj4gcGxhdGZvcm1fcHJvZmlsZQ0K
PiA+Pj4gaW4gdGhlIG5leHQgUkZDLg0KPiA+Pj4NCj4gPj4+IEFsc28gbm90aWNlIGhvdyBJJ3Zl
IHRyaWVkIHRvIGNvbnNpc3RlbnRseSB1c2UgQUMvYmF0dGVyeSBpbiBteSBsYXN0IHJlcGx5LA0K
PiA+Pj4gREMgcmVhbGx5IGlzIG5vdCBhIGdvb2QgdGVybSBmb3IgIm9uIGJhdHRlcnkiLiBBQyBh
bHNvIGlzIHNvcnQgb2YgZHViaW91cw0KPiA+Pj4gZm9yICJjb25uZWN0ZWQgdG8gYW4gZXh0ZXJu
YWwgcG93ZXItc3VwcGx5IiBidXQgaXRzIHVzZSBmb3IgdGhhdCBpcyBzb3J0YQ0KPiA+Pj4gY29t
bW9uIGFuZCBpdCBpcyBuaWNlIGFuZCBzaG9ydC4NCj4gPj4NCj4gPj4gT25lIGxhc3QgcmVxdWVz
dCBmb3IgdGhlIHYyIFJGQywgcGxlYXNlIGFsc28gQ2MgQmFzdGllbiBOb2NlcmEsIHNvIHRoYXQN
Cj4gPj4gaGUgY2FuIHRha2UgYSBsb29rIGF0IHRoZSBwcm9wb3NlZCB1YXBpIGNoYW5nZXMgZnJv
bSB0aGUgdXNlcnNwYWNlIHNpZGUNCj4gPj4gb2YgdGhpbmdzLg0KPiA+Pg0KPiA+IEFjayAtIHdp
bGwgZG8uDQo+IA0KPiBTbyBJJ3ZlIGJlZW4gdGhpbmtpbmcgYSBiaXQgbW9yZSBhYm91dCB0aGlz
IHdoaWxlIEkgd2FzIG91dHNpZGUgZm9yIHNvbWUNCj4gZnJlc2ggYWlyLg0KPiANCj4gRmlyc3Qg
b2YgYWxsIGxldCBtZSBzYXkgdGhhdCBJIGRvIGFncmVlIHRoYXQgdGhlIGhhdmluZyBpbiBlc3Nl
bmNlIDYNCj4gZGlmZmVyZW50IHByb2ZpbGVzIHRoaW5nIG5lZWRzIGEga2VybmVsIHNvbHV0aW9u
Lg0KPiANCj4gV2hhdCBJJ20gbm90IGVudGlyZWx5IHN1cmUgYWJvdXQgaXMgaWYgdGhpcyBuZWVk
cyB0byBiZSBzb21ldGhpbmcNCj4gZ2VuZXJpYywgd2l0aCBhIG5ldyB1c2Vyc3BhY2UtQVBJIGFz
IHlvdSBwcm9wb3NlZCBpbiB0aGUgdjEgUkZDLA0KPiBvciBpZiBpdCB3b3VsZCBiZSBiZXR0ZXIg
dG8ganVzdCBzb2x2ZSB0aGlzIGluIHRoaW5rcGFkX2FjcGkuYyAuDQo+IA0KPiBOb3cgdGhhdCBJ
J3ZlIGEgYmV0dGVyIGdyYXNwIG9mIHRoZSBwcm9ibGVtLCBJJ2xsIHN0YXJ0IGEgbmV3IGVtYWls
DQo+IHRocmVhZCBvbiB0aGlzIHRvbW9ycm93IHdpdGggYWxsIHRoZSB2YXJpb3VzIHRha2UtaG9s
ZGVycyBpbiB0aGUgQ2MNCj4gdG8gdHJ5IGFuZCBhbnN3ZXIgdGhhdCBxdWVzdGlvbi4NCg0KSSd2
ZSBiZWVuIHZpZXdpbmcgTGVub3ZvJ3MgaW1wbGVtZW50YXRpb24gYXMgInRoZSBmaXJzdCBvbmUg
dG8gZG8gaXQgdGhpcyB3YXkiLg0KSW4gdGhlIGZ1dHVyZSBBTUQgcGxhbnMgdG8gc3VibWl0IGEg
ZHJpdmVyIHRoYXQgcHJvdmlkZXMgcGxhdGZvcm0gcHJvZmlsZXMNCmZvciBzb21lIFNPQ3MuICBJ
dCB3aWxsIHByb3ZpZGUgc2ltaWxhciBjYXBhYmlsaXRpZXMgdG8gd2hhdCB0aGlua3BhZF9hY3Bp
IGRvZXMuDQoNCkkgaGF2ZW4ndCBtZW50aW9uZWQgaXQgdGh1cyBmYXIgYmVjYXVzZSBpdCdzIHN0
aWxsIHVuZGVyIGRldmVsb3BtZW50IGFuZCBvZg0KY291cnNlIHRoaXMgY291bGQgY2hhbmdlIG9y
IGJlIGNhbmNlbGxlZC4gIEkgZXhwZWN0IHRoYXQgdGhlIGRlY2lzaW9uIG1hZGUNCmFyb3VuZCB3
aGF0IHRvIGRvIHdpdGggdGhpbnBhZF9hY3BpIHdpbGwgYWxzbyBoYXZlIHJhbWlmaWNhdGlvbnMg
Zm9yDQp3aGF0IHRoYXQgZHJpdmVyIHdpbGwgZG8gdG9vIHdoZW4gaXQncyBmaW5pc2hlZCBhbmQg
c3VibWl0dGVkLg0KDQpQbGVhc2UgaW5jbHVkZSBTaHlhbSAobm93IG9uIENDKSBpbiB0aGUgbmV3
IGRpc2N1c3Npb24gdGhyZWFkLiAgSGlzIHRlYW0NCm93bnMgdGhhdCBuZXcgc29sdXRpb24gSSBt
ZW50aW9uIGFuZCB0aGlzIGNhbiBhZmZlY3QgdGhlaXIgZGV2ZWxvcG1lbnQgDQpkaXJlY3Rpb24g
dG9vLg0KDQpJIHNheSB0aGlzIGFsbCB0byBtZWFuICJ0aGlua3BhZF9hY3BpIG1pZ2h0IG5vdCBi
ZSB0aGUgb3V0bGllciIuDQoNCj4gDQo+IEl0IHByb2JhYmx5IGlzIGEgZ29vZCBpZGVhIHRvIHdh
aXQgd2l0aCBkb2luZyBhIHYyIG9mIHRoZSBSRkMgdW50aWwNCj4gd2UndmUgaGFkIHRoYXQgZGlz
Y3Vzc2lvbi4uLg0KPiANCj4gUmVnYXJkcywNCj4gDQo+IEhhbnMNCg==
