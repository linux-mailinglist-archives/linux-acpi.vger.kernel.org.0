Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6EC5EF27A
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Sep 2022 11:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbiI2JpB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Sep 2022 05:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbiI2Jo2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Sep 2022 05:44:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666D914978A;
        Thu, 29 Sep 2022 02:44:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3314B82366;
        Thu, 29 Sep 2022 09:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D36C433C1;
        Thu, 29 Sep 2022 09:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664444661;
        bh=OPt/mgPBK/Iow3NJQykNDXoE16/nqn1xF/qJJ4hy5ss=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bH8zAMcyzyKgVT65ZfL3M11maQSSyJWQseKYBf7Q3nqTlU8S8pD9j5qMa6HY27mNK
         qxIgaZ9b//rk9Dl9eUq83WdjpAlLpnofMQHcJG6gq+Kfcwb14Vw74lLZ6g703DTeDp
         ZjG6P2XnyWJSoVPGGxWeZurLsIyo9xnyLTRzRQpfcSE3dQO8uum5kR1n/uuw8gehhv
         7EY3WUhgEYaVdwfBlbC/wEjiQvOg2Rtd6d8vW7AUFaFjxJWCSbRspp/k7B9UCq35R2
         xqoD7crtpRcPmSV49TecZyf226t+emectNbJhiQltWP3EYg8a76dMWFh7E+1IZsOJh
         fqUE27QpH/nKQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1odq5b-00DVI6-5f;
        Thu, 29 Sep 2022 10:44:19 +0100
Date:   Thu, 29 Sep 2022 05:44:18 -0400
Message-ID: <86ill67bwt.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Jianmin Lv <lvjianmin@loongson.cn>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH V1 1/2] irqchip/loongson-pch-pic: Support to set irq type for ACPI path
In-Reply-To: <71fc2d5b-fc3c-0a2d-65ce-df7d5bb26503@loongson.cn>
References: <1660615291-35409-1-git-send-email-lvjianmin@loongson.cn>
        <1660615291-35409-2-git-send-email-lvjianmin@loongson.cn>
        <86leq37duw.wl-maz@kernel.org>
        <71fc2d5b-fc3c-0a2d-65ce-df7d5bb26503@loongson.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: lvjianmin@loongson.cn, tglx@linutronix.de, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, jiaxun.yang@flygoat.com, chenhuacai@loongson.cn, bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 28 Sep 2022 22:35:17 -0400,
Jianmin Lv <lvjianmin@loongson.cn> wrote:
>
> On 2022/9/28 =E4=B8=8B=E5=8D=8810:49, Marc Zyngier wrote:
> > On Mon, 15 Aug 2022 22:01:30 -0400,
> > Jianmin Lv <lvjianmin@loongson.cn> wrote:
> >>=20
> >> For ACPI path, the translate callback used IRQ_TYPE_NONE and ignored
> >> the irq type in fwspec->param[1]. For supporting to set type for
> >> irqs of the irqdomain, fwspec->param[1] should be used to get irq
> >> type.
> >>=20
> >> On Loongson platform, the irq trigger type of PCI devices is
> >> high level, so high level triggered type is inputed to acpi_register_g=
si
> >> when create irq mapping for PCI devices.
> >>=20
> >> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> >> ---
> >>   drivers/acpi/pci_irq.c                 |  3 ++-
> >>   drivers/irqchip/irq-loongson-pch-pic.c | 10 ++++++----
> >>   2 files changed, 8 insertions(+), 5 deletions(-)
> >=20
> > $ ./scripts/get_maintainer.pl drivers/acpi/pci_irq.c
> > Bjorn Helgaas <bhelgaas@google.com> (supporter:PCI SUBSYSTEM)
> > "Rafael J. Wysocki" <rafael@kernel.org> (supporter:ACPI)
> > Len Brown <lenb@kernel.org> (reviewer:ACPI)
> > linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM)
> > linux-acpi@vger.kernel.org (open list:ACPI)
> > linux-kernel@vger.kernel.org (open list)
> >=20
> > How about you start Cc-ing some of the relevant people?
> >=20
> Ok, thanks, I'll cc relevant people list here.
>=20
> >>=20
> >> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> >> index 08e1577..34483b3 100644
> >> --- a/drivers/acpi/pci_irq.c
> >> +++ b/drivers/acpi/pci_irq.c
> >> @@ -393,7 +393,8 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
> >>   	 * controller and must therefore be considered active high
> >>   	 * as default.
> >>   	 */
> >> -	int polarity =3D acpi_irq_model =3D=3D ACPI_IRQ_MODEL_GIC ?
> >> +	int polarity =3D acpi_irq_model =3D=3D ACPI_IRQ_MODEL_GIC ||
> >> +		       acpi_irq_model =3D=3D ACPI_IRQ_MODEL_LPIC ?
> >>   				      ACPI_ACTIVE_HIGH : ACPI_ACTIVE_LOW;
> >=20
> > The comment just above this only talks about ARM. Should it be
> > updated?=20
>=20
> Ok, I'll update the comment.
>=20
>=20
> > Is this a limitation of the underlying interrupt controller?
> >=20
> It's the limitation that pci interrupt source of LoongArch only sends
> high level trigger signal to interrupt controller(though, pci spec
> requires asserted low).

Right, so this is the opposite problem ARM has.

But is it *always* intended to be built like this? Or is it a one-off
for this generation of Loongarch systems, to be fixed at a later time?

>=20
>=20
> >>   	char *link =3D NULL;
> >>   	char link_desc[16];
> >> diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/=
irq-loongson-pch-pic.c
> >> index b6f1392..5067010 100644
> >> --- a/drivers/irqchip/irq-loongson-pch-pic.c
> >> +++ b/drivers/irqchip/irq-loongson-pch-pic.c
> >> @@ -177,13 +177,15 @@ static int pch_pic_domain_translate(struct irq_d=
omain *d,
> >>   	if (fwspec->param_count < 1)
> >>   		return -EINVAL;
> >>   -	if (of_node) {
> >> +	if (of_node)
> >>   		*hwirq =3D fwspec->param[0] + priv->ht_vec_base;
> >> -		*type =3D fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
> >> -	} else {
> >> +	else
> >>   		*hwirq =3D fwspec->param[0] - priv->gsi_base;
> >> +
> >> +	if (fwspec->param_count > 1)
> >> +		*type =3D fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
> >> +	else
> >>   		*type =3D IRQ_TYPE_NONE;
> >=20
> > Isn't that a change in behaviour if of_node is non-NULL and
> > param_count=3D=3D1?
> >=20
>=20
> It seems that current code here has bug that if fwspec->param_count=3D=3D1
> and of_node is non-null, fwspec->param[1] will be accessed, which is
> introduced from previous patch(irqchip/loongson-pch-pic: Add ACPI init
> support). Before the patch, for non-null of_node, translate
> callback(use irq_domain_translate_twocell) will return -EINVAL if
> fwspec->param_count < 2.
>=20
> For ACPI path, fwspec->param_count can be 1 or 2.
>=20
> So in this patch, I'll fix the bug and change the code as following:
>=20
>         if (fwspec->param_count < 1)
>                 return -EINVAL;
>=20
>         if (of_node) {
>                 if (fwspec->param_count < 2)
>                         return -EINVAL;
>=20
>                 *hwirq =3D fwspec->param[0] + priv->ht_vec_base;
>                 *type =3D fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
>         } else {
>                 *hwirq =3D fwspec->param[0] - priv->gsi_base;
>=20
>                 if (fwspec->param_count > 1)
>                         *type =3D fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
>                 else
>                         *type =3D IRQ_TYPE_NONE;
>         }
>
>=20
> >> -	}
> >>     	return 0;
> >>   }
> >=20
> > This irqchip change should probably be a separate patch.
> >=20
>=20
> As a separate patch, the input trigger type of pci devices will be low
> level because of lacking of workaround to acpi_pci_irq_enable, which
> will cause kernel hang, unless the patch of workaround to
> acpi_pci_irq_enable is in front of this separated patch.

That seems like a sensible requirement, but I really want to
understand whether PCI Loongarch will *always* generate INTx as
ACTIVE_HIGH or not. Because if that is ever going to change, we will
need a different way to inform the irqchip about the polarity
inversion.

	M.

--=20
Without deviation from the norm, progress is not possible.
