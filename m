Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 171DE14B475
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2020 13:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgA1Muo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jan 2020 07:50:44 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:38203 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgA1Muo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jan 2020 07:50:44 -0500
Received: from mail-qv1-f50.google.com ([209.85.219.50]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MfYDO-1jTZIA1JYO-00g0pf; Tue, 28 Jan 2020 13:50:42 +0100
Received: by mail-qv1-f50.google.com with SMTP id dc14so6158053qvb.9;
        Tue, 28 Jan 2020 04:50:42 -0800 (PST)
X-Gm-Message-State: APjAAAUlbMj3edb9FViq9eps2RGb60zdG8lN3Vf74v43TmedTXTOEPnx
        BmDNf0v0QfjPbLYkXhvxwbc6vr7YH5m7rPxNuxs=
X-Google-Smtp-Source: APXvYqwJy4DwfEzTsOkoi0YCpAanaatx64QLkeoLB3399GuTavZPkuD/rRK//KCoPuUtr3vyStofBIgJqCNGfmKx4so=
X-Received: by 2002:a0c:ead1:: with SMTP id y17mr20934030qvp.210.1580215841088;
 Tue, 28 Jan 2020 04:50:41 -0800 (PST)
MIME-Version: 1.0
References: <1580210059-199540-1-git-send-email-john.garry@huawei.com> <1580210059-199540-3-git-send-email-john.garry@huawei.com>
In-Reply-To: <1580210059-199540-3-git-send-email-john.garry@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 28 Jan 2020 13:50:25 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2famGETLM7JgEh+eUJ9HSqm_Fu79uAkU_BPOkDvV2ROg@mail.gmail.com>
Message-ID: <CAK8P3a2famGETLM7JgEh+eUJ9HSqm_Fu79uAkU_BPOkDvV2ROg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] soc: Add a basic ACPI generic driver
To:     John Garry <john.garry@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, jeremy.linton@arm.com,
        Olof Johansson <olof@lixom.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        gregkh <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:3nMHLYujwFcb9tdRgyh5pqOB2vOeaVGdkAJy7Iigx6xOA/kppSB
 Xmzua0GGpQ4F+4mZwBygccrfbLrpJDE/+hqngCif9WS/q4wGfCRsaZSvF9rV9Qk7RDu2VHm
 P0FZS9HOb7Yyez4DE4I/oBJspzXWb7NvXMRnqJTzrPl0tKW30LH7gzsNpITyW06DmRlUZ5o
 ca6a12vh1gngg6T66vv3Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MDP6mq5stY0=:AeGKJuejOqVgqxsGJ0wycJ
 11NhK/41P7k7onJk3BhJdklMt7NQpdAUSaFj30J+HeCFAlSez13JYgG+Nk5VM2DqatIJKVMhs
 CU5PMSwMns2HR8j2FKn+Xl/2NC0SBg9fCfjSNEgrPsLy8RSniQ/8jpTfxSbtvLVlRxcKlJn7l
 cotp5oMjXFSvjzsTqdXAgyjOYwgc68/s01y6SWWJDYTlC4HGULTQbWvgy7+OTCk/EC5uLH9qQ
 Tj7TlNl8SovLqHxgtxqTVNNL5JmKMdAhu0SL2C7jSHzmlho2IgxV0KPmBHKFfPwREXWhJfJqk
 APp7l0QfVPuuo+M2BB0LSJwXpmDv8+nSnixdH4Y49d8K8asb6OMAhpHHiSRJIaohYvAOpQzr1
 lkIvXGdwAD6XB67DBtTKgAWF1WvN8njLlLBkknX+f9OgxCtSt4YVpj/0JRH9uIYOGIVEB4GAA
 ofPYzP8pPsseGKgnWpECxUWi3N2lGp3wP1BQcmY+dfOXs6FgIMceWEJFQHdiYZmVRZjnA4W0B
 G5tEhbe+/lRKG1thA78s7704I0ZVT1fe40Emrz0NR4d8az8i0ndWqHDm1ppTybDUd6kHGmb0o
 jB1zUDKRK6ceSnFYIEc6xbXe4Rv7p5uqbk0DdjmuVTQcSABshpPNI6BCtt7NgxcZqc3VTu4cI
 gvcw2oTmrKilAk/UlD2sIBhUMKnwyUsmLPgwxy4k3WHstEOVyBnj7eeKNGsIOEL91O8I/u8iP
 ULkxSF+j7uzVagC7UIIcRxx9YH7mN/kdSxCGyF7u9Vog9lOYaPMfFe0RF13WtTg7cgp8BWuiP
 HPz0PP10JP2aMGQhcKwA6m8cVbaxcZevJ6XXaN9E/F4zEo2+zw=
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 28, 2020 at 12:18 PM John Garry <john.garry@huawei.com> wrote:
>
> Add a generic driver for platforms which populate their ACPI PPTT
> processor package ID Type Structure according to suggestion in the ACPI
> spec - see ACPI 6.2, section 5.2.29.3 ID structure Type 2.
>
> The soc_id is from member LEVEL_2_ID.
>
> For this, we need to use a whitelist of platforms which are known to
> populate the structure as suggested.
>
> For now, only the vendor and soc_id fields are exposed.
>
> Signed-off-by: John Garry <john.garry@huawei.com>

Would it be possible to make this the root device for all on-chip devices
to correctly reflect the hierarchy inside of the soc?

> +/*
> + * Known platforms that fill in PPTT package ID structures according to
> + * ACPI spec examples, that being:
> + * - Custom driver attribute is in ID Type Structure VENDOR_ID member
> + * - SoC id is in ID Type Structure LEVEL_2_ID member
> + *    See ACPI SPEC 6.2 Table 5-154 for PPTT ID Type Structure
> + */
> +static struct acpi_platform_list plat_list[] = {
> +       {"HISI  ", "HIP08   ", 0, ACPI_SIG_PPTT, all_versions},
> +       { } /* End */
> +};

That matches a single machine, right? It doesn't seem very generic
that way.

> +struct acpi_generic_soc_struct {
> +       struct soc_device_attribute dev_attr;
> +       u32 vendor;
> +};
> +
> +static ssize_t vendor_show(struct device *dev,
> +                          struct device_attribute *attr,
> +                          char *buf)
> +{
> +       struct acpi_generic_soc_struct *soc = dev_get_drvdata(dev);
> +       u8 vendor_id[5] = {};
> +
> +       *(u32 *)vendor_id = soc->vendor;
> +
> +       return sprintf(buf, "%s\n", vendor_id);
> +}

I'd rather not see nonstandard attributes in a "generic" driver at
all. Maybe the
you can simply concatenate the vendor and  LEVEL_2_ID into a single string
here?

> +                       soc = kzalloc(sizeof(*soc), GFP_KERNEL);
> +                       if (!soc)
> +                               return -ENOMEM;
> +
> +                       soc_dev_attr = &soc->dev_attr;
> +                       soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%s",
> +                                                        soc_id);

On the other hand, it would make sense to fill out additional fields here.
You have already matched the name of the board from the
acpi_platform_list, so there are two strings available that could be put
into the "machine" field, and it would make sense to fill out "family" with
something that identifies it as coming from ACPI PPTT data.

             Arnd
