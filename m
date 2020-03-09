Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E35AC17E559
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2020 18:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgCIRH5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Mar 2020 13:07:57 -0400
Received: from mail-bn8nam12on2104.outbound.protection.outlook.com ([40.107.237.104]:62464
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727222AbgCIRH5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 9 Mar 2020 13:07:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTbyoSN1I1QxFSogODeFPRg1P/LMl0AwCkShrY9lTTVXAMZN5lIDs3Nnw+CFAg7P0tl2yazYngI6jBjsXSsQDsXTlDHM24rzmImxbxqsMqGEfzMqSEXoKP66IV+UtDNdEfFR9rkGvby7nw2WgnZNfpLppEDbHASwvNKnP6IV0XS6EuxmZNf9AZ7/sFtxaIQGVZqOGMANxOCcGzp9139crzrf22bn9A1sc6qij1b9JYdYeN0EHvxcumDXwBDVQOxyaBXJ3KNzJCr+wzwlGzdfrtlOObRbNdhgzhCWUqCrUYUx2zQfcWbhgHCmZSCvrStA0gOP27ICd6UgEM43537tKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wAta9jpApZefoyPc5L81t5u2A5TXjZb0BAqZxeLNdc=;
 b=CNWSDoAyZo/nu8qL2lp4oO+l7v+gDyNfxSvqEbmXSsy227rWeeYRzzGGTE0VYA2tMX/C8fiiVl6FhjMUhJZYwxGFknezSfn6rKgGHqfv2iDGrhhwNbQ4Ad3pcrTYOwnqwhUtJktub3OvSVeNqlMFxCgCQSEwbr2bInMaf62/SoVXioghke32bMnaZQsljAb/EiekelCtzjOeXEZoUaAKJn2W4GUYYaXMnwKVZ6hArud6R0A9eZGO8pJW/PjWRaL5simQObYpjO55LsYEllIb94g3CiC/YQhQBc0OfHRUEriDgg7tl6kUWH0bQJcHLMhWJR6Zn/uphQpFke3upCto2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wAta9jpApZefoyPc5L81t5u2A5TXjZb0BAqZxeLNdc=;
 b=gLDWDlAtM9WK0eihI899T07xTP6Ods2zVHBAH8ePBPTfW0JtG1siweeVEAsc761kRfymJEQ12O7lEty35ExZu6sYYkPUNfsNcMTfumuv0j6ViqT8tSn6KorDs3yiwlW7iS2oFJjj40X/Tqu09vq+kI2uiuI7c9miFw4tHAXCol4=
Received: from CY1PR01MB2137.prod.exchangelabs.com (2a01:111:e400:c637::8) by
 CY1PR01MB2074.prod.exchangelabs.com (2a01:111:e400:c613::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Mon, 9 Mar 2020 17:07:51 +0000
Received: from CY1PR01MB2137.prod.exchangelabs.com
 ([fe80::6148:f6cc:5af1:d331]) by CY1PR01MB2137.prod.exchangelabs.com
 ([fe80::6148:f6cc:5af1:d331%12]) with mapi id 15.20.2772.019; Mon, 9 Mar 2020
 17:07:50 +0000
From:   Tyler Baicar OS <baicar@os.amperecomputing.com>
To:     James Morse <james.morse@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Tyler Baicar <tyler@amperecomputing.com>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/3] ACPI / APEI: Kick the memory_failure() queue for
 synchronous errors
Thread-Topic: [PATCH 2/3] ACPI / APEI: Kick the memory_failure() queue for
 synchronous errors
Thread-Index: AQHV7l9islU0t33K/0yc+Wh9NLI+dqhAdbd9
Date:   Mon, 9 Mar 2020 17:07:50 +0000
Message-ID: <CY1PR01MB2137B6CC34E2D31F7618A951E3FE0@CY1PR01MB2137.prod.exchangelabs.com>
References: <20200228174817.74278-1-james.morse@arm.com>,<20200228174817.74278-3-james.morse@arm.com>
In-Reply-To: <20200228174817.74278-3-james.morse@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=baicar@os.amperecomputing.com; 
x-originating-ip: [108.169.132.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41b7addc-2cf5-4512-dcb1-08d7c44c6660
x-ms-traffictypediagnostic: CY1PR01MB2074:|CY1PR01MB2074:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY1PR01MB20746C0C55AE213BE24B3954E3FE0@CY1PR01MB2074.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0337AFFE9A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(136003)(39840400004)(366004)(396003)(189003)(199004)(26005)(66946007)(52536014)(33656002)(4326008)(81166006)(66476007)(81156014)(9686003)(64756008)(66556008)(8676002)(66446008)(6506007)(55016002)(76116006)(53546011)(110136005)(54906003)(316002)(2906002)(7416002)(8936002)(71200400001)(5660300002)(186003)(7696005)(86362001)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR01MB2074;H:CY1PR01MB2137.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M3TCdZKkHdLxicpqSxFcf/CsunULAwCt96STcm7olOxMZnw5tADaiTgErT9EQgQv9UmIlUmJ9sLjxMx39GRlUlJdKS08et5cwgJVG7uX1dTr1kdpzKabM8uGT/0/artnO6BE4YTlvw/ULwAV/ud4aNpLTJDPfwAX3bNLFlgPM8X6C9C33tr46R2oLS0w4cATB/1OC99ahqXyQhhsd4nJOHWX1nij5wl/n2jg1UQ58TwtBqptalVvs7iSByBHNJjguacw0oGCMUwX0R+4N1r62ogu82kDljaA7cZvbBp1a6hnsMLu5LO9z5fzwYvQdB40M6mxJ9DXqmANPOPd1q0xZVKM03Nxr9qSTUQa2cgIqQKQ6yT/lLs5ukD5rFj5N8WkepJP2Qc/9q02618OPto6YyGhAU1qt3OtPl++/sSY6eKBsYDOd+7bjQnso9MLOM/2
x-ms-exchange-antispam-messagedata: SSsvskZs0LVMdaWcAcK4wiNUy2NUJJnlSnJKCU1inOa6UhFIhf1ryIn9O5XG6CgLJs+5+EOQy7J0HK7ArayDbpWw3DSjSq4/flk1b2Ge3Hbo0Py7LIMhx9/9VcB73b9eYuhHP9vO5CrjDEEx6jy3Ow==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b7addc-2cf5-4512-dcb1-08d7c44c6660
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 17:07:50.7728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: da+XWrN/11G8GqGcLcHKZUOg5eu6/AjP1O+gAtN/x0tiUtid5kyBX2Fi8Kzjmcs4VKFDL85eHt7SxaaIjU2iaYmL7wXa5MuW5KZbzPaLpLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR01MB2074
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello James,=0A=
=0A=
On Fri, Feb 28, 2020 at 12:49 PM James Morse <james.morse@arm.com> wrote:=
=0A=
>=0A=
> -static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gd=
ata, int sev)=0A=
=0A=
> +static bool ghes_handle_memory_failure(struct ghes *ghes,=0A=
> +                                      struct acpi_hest_generic_data *gda=
ta,=0A=
> +                                      int sev)=0A=
=0A=
It doesn't look like ghes needs to be added as a parameter to this=0A=
function, unless I'm missing something :)=0A=
=0A=
>  {=0A=
> -#ifdef CONFIG_ACPI_APEI_MEMORY_FAILURE=0A=
>         unsigned long pfn;=0A=
>         int flags =3D -1;=0A=
>         int sec_sev =3D ghes_severity(gdata->error_severity);=0A=
>         struct cper_sec_mem_err *mem_err =3D acpi_hest_get_payload(gdata)=
;=0A=
>=0A=
> +       if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))=0A=
> +               return false;=0A=
> +=0A=
>         if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))=0A=
> -               return;=0A=
> +               return false;=0A=
>=0A=
>         pfn =3D mem_err->physical_addr >> PAGE_SHIFT;=0A=
>         if (!pfn_valid(pfn)) {=0A=
>                 pr_warn_ratelimited(FW_WARN GHES_PFX=0A=
>                 "Invalid address in generic error data: %#llx\n",=0A=
>                 mem_err->physical_addr);=0A=
> -               return;=0A=
> +               return false;=0A=
>         }=0A=
>=0A=
>         /* iff following two events can be handled properly by now */=0A=
> @@ -440,9 +465,12 @@ static void ghes_handle_memory_failure(struct acpi_h=
est_generic_data *gdata, int=0A=
>         if (sev =3D=3D GHES_SEV_RECOVERABLE && sec_sev =3D=3D GHES_SEV_RE=
COVERABLE)=0A=
>                 flags =3D 0;=0A=
>=0A=
> -       if (flags !=3D -1)=0A=
> +       if (flags !=3D -1) {=0A=
>                 memory_failure_queue(pfn, flags);=0A=
> -#endif=0A=
> +               return true;=0A=
> +       }=0A=
> +=0A=
> +       return false;=0A=
>  }=0A=
>=0A=
=0A=
This series looks good to me overall. I'm going to pull it and give it a sp=
in.=0A=
=0A=
Thanks,=0A=
Tyler=
