Return-Path: <linux-acpi+bounces-14294-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A37AAD673E
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 07:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 528167A8BC7
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 05:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E7B1E7C34;
	Thu, 12 Jun 2025 05:20:24 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29171A9B52
	for <linux-acpi@vger.kernel.org>; Thu, 12 Jun 2025 05:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749705624; cv=none; b=PlizABayYayiuaEBa3iuXRkN95OP47mgzj+KGApuqFbzWkzk8LgLpOOxS3To0VFiMw831OxGSa51tk/8h5ZBu7l15QKR2s/fr04uksC3SCFsPpQ3SCAxV3IiG1UVtj+1RLUKRwVhrezrOGVNSNVXroRSRQVWvKb+4IrMu/I/hUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749705624; c=relaxed/simple;
	bh=7ZTSePSJwjMCONKoubPG5ZhZkuUfXtMIprus1UGIa68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2JH/PvSy2HOON/duHsFdjcjtdWtB3BF1T2btOsi+FlKfZxUqzK2ByTmfUmPWH8diMxK+L0ZVQ5eYFWmSMZLtwAB8KQvp49r9+nTg2fl3dHo97N5pqH7ygEkVfTjtFP6akrNErY6i+Vq0hK8Dnw6AtdTSZvKrjvlttPQV2xdNxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from mail-wr1-f53.google.com (unknown [209.85.221.53])
	by APP-03 (Coremail) with SMTP id rQCowAB3xEzYYUpojDrtBQ--.36828S2;
	Thu, 12 Jun 2025 13:12:57 +0800 (CST)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a36748920cso498747f8f.2
        for <linux-acpi@vger.kernel.org>; Wed, 11 Jun 2025 22:12:56 -0700 (PDT)
X-Gm-Message-State: AOJu0YyLodgr+RU3RPzJ7Jfh7r6cCQNtnN7CQFCumdTuTzVwaBMgXNJF
	F9vi5HQZOfR7/6IvXF0rcJiBjmeBVkFGR/fHRrfC5KTGr9jJmZGWF31X2MtoUjc/+pXXuTfFGsD
	+RfGiXbAUKzmeEeE1eJ9ymRUxmCSqjjc=
X-Google-Smtp-Source: AGHT+IFWRj/PWOKGf51d2oaMZnzeG/grWPAsHzvZKKgNZiKqZU8g1nIkUVuP5UTHpG8QVKmySBvveNrg0xWB33e2Y5o=
X-Received: by 2002:a05:6000:2911:b0:3a5:2875:f985 with SMTP id
 ffacd0b85a97d-3a5608198c4mr1407936f8f.59.1749705174882; Wed, 11 Jun 2025
 22:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aEmdnuw715btq7Q5@stanley.mountain>
In-Reply-To: <aEmdnuw715btq7Q5@stanley.mountain>
From: Zhe Qiao <qiaozhe@iscas.ac.cn>
Date: Thu, 12 Jun 2025 13:12:43 +0800
X-Gmail-Original-Message-ID: <CALhs5=1-QP04GEMUjMHgpCtAbUmW=zFpR=7B4KLuJ1wkT2JQmg@mail.gmail.com>
X-Gm-Features: AX0GCFvPP_bVfoPSOQuaj-Ol1jWDGPeQ9z-zHVwVrQVWImntePBbVXgswfDkfZU
Message-ID: <CALhs5=1-QP04GEMUjMHgpCtAbUmW=zFpR=7B4KLuJ1wkT2JQmg@mail.gmail.com>
Subject: Re: [bug report] PCI/ACPI: Fix allocated memory release on error in pci_acpi_scan_root()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:rQCowAB3xEzYYUpojDrtBQ--.36828S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF1xKw15Wry3AFyUtF13Jwb_yoW5AF1UpF
	4Svr4UJr4kJr1jqrZ7A3Z5Zr4furWYkrW5KryIyrsxAa15ur4YgFZIkr1F9FyDWFs5Aa1j
	vFWqqF1UCr1DAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvSb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjc
	xK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY
	07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxV
	WUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAK
	I48JMxkIecxEwVCI4VW8WwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43
	ZEXa7IUY7-PUUUUUU==
X-CM-SenderInfo: ptld061kh6x2xfdvhtffof0/

Hi Dan Carpenter,

On Wed, Jun 11, 2025 at 11:15=E2=80=AFPM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> Hello Zhe Qiao,
>
> Commit 631b2af2f357 ("PCI/ACPI: Fix allocated memory release on error
> in pci_acpi_scan_root()") from Apr 30, 2025 (linux-next), leads to
> the following Smatch static checker warning:
>
>         drivers/pci/pci-acpi.c:1712 pci_acpi_scan_root()
>         error: double free of 'root_ops' (line 1711)
>
> drivers/pci/pci-acpi.c
>     1667 struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>     1668 {
>     1669         struct acpi_pci_generic_root_info *ri;
>     1670         struct pci_bus *bus, *child;
>     1671         struct acpi_pci_root_ops *root_ops;
>     1672         struct pci_host_bridge *host;
>     1673
>     1674         ri =3D kzalloc(sizeof(*ri), GFP_KERNEL);
>     1675         if (!ri)
>     1676                 return NULL;
>     1677
>     1678         root_ops =3D kzalloc(sizeof(*root_ops), GFP_KERNEL);
>     1679         if (!root_ops)
>     1680                 goto free_ri;
>     1681
>     1682         ri->cfg =3D pci_acpi_setup_ecam_mapping(root);
>     1683         if (!ri->cfg)
>     1684                 goto free_root_ops;
>     1685
>     1686         root_ops->release_info =3D pci_acpi_generic_release_info=
;
>     1687         root_ops->prepare_resources =3D pci_acpi_root_prepare_re=
sources;
>     1688         root_ops->pci_ops =3D (struct pci_ops *)&ri->cfg->ops->p=
ci_ops;
>     1689         bus =3D acpi_pci_root_create(root, root_ops, &ri->common=
, ri->cfg);
>     1690         if (!bus)
>     1691                 goto free_cfg;
>
> The acpi_pci_root_create() function frees root_ops on error in
> pci_acpi_generic_release_info().  I think there is only one error
> path where it frees "ri->cfg".  I probably would advise you to re-write
> the the error handling in acpi_pci_root_create().

Thanks, this is really an unexpected gain for me. I didn't notice that
the memory
release operation has been implemented in the pci_acpi_generic_release_info
function. But I think it's a bit unclear in the code logic to release
these memories
in the pci_acpi_generic_release_info function. As you pointed out, I
want to let the
pci_acpi_generic_release_info function return directly, and put all the mem=
ory
release operations into the error handling part of the
pci_acpi_scan_root function.
What do you think of this? If you have any better suggestions, please
let me know.

>
>     1692
>     1693         /* If we must preserve the resource configuration, claim=
 now */
>     1694         host =3D pci_find_host_bridge(bus);
>     1695         if (host->preserve_config)
>     1696                 pci_bus_claim_resources(bus);
>     1697
>     1698         /*
>     1699          * Assign whatever was left unassigned. If we didn't cla=
im above,
>     1700          * this will reassign everything.
>     1701          */
>     1702         pci_assign_unassigned_root_bus_resources(bus);
>     1703
>     1704         list_for_each_entry(child, &bus->children, node)
>     1705                 pcie_bus_configure_settings(child);
>     1706
>     1707         return bus;
>     1708
>     1709 free_cfg:
>     1710         pci_ecam_free(ri->cfg);
>     1711 free_root_ops:
> --> 1712         kfree(root_ops);
>     1713 free_ri:
>     1714         kfree(ri);
>     1715         return NULL;
>     1716 }
>
> regards,
> dan carpenter


