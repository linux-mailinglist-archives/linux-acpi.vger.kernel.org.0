Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0931DE870
	for <lists+linux-acpi@lfdr.de>; Fri, 22 May 2020 16:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbgEVODI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 May 2020 10:03:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729399AbgEVODH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 May 2020 10:03:07 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1A5D21532;
        Fri, 22 May 2020 14:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590156186;
        bh=PC+uay0MBJgZb1HrY/dFqAwSM1Ui19cXenE7vxJsLa0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TyuLw6VByNbf3Akwv2nKdLOf67tVruG4eCMaraUTwL3hqUcblq+NKU7TLQq2/q6P7
         Urxcqn76R9RqZme2DhUwavYqB037CsQzmbczJvuF46pziO3YVMZzasuU6xNRwmBL7f
         vNme/VqvGA771XxXTyZk9gWeSPQE+zPAaWiItqP8=
Received: by mail-oi1-f172.google.com with SMTP id y85so9313928oie.11;
        Fri, 22 May 2020 07:03:06 -0700 (PDT)
X-Gm-Message-State: AOAM530eQyIJR0jdXX6YY+gR67qMyBF45iXIF2NmbmwR9QUHQyaZsyun
        vW3nFyjNXRK0U/FTBAKLYYPZ0tVy725I80M5Nw==
X-Google-Smtp-Source: ABdhPJz4NPfC/e/rYdjknKeQRurJR6ul989Dp2cHUGc/fsPE+++fhkbh8JKvoUs1QPU5OvCiTH3oazU9MRQGNkQBnro=
X-Received: by 2002:aca:f084:: with SMTP id o126mr2798405oih.106.1590156185879;
 Fri, 22 May 2020 07:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200521130008.8266-10-lorenzo.pieralisi@arm.com> <CAL_Jsq+h18gH2D3B-OZku6ACCgonPUJcUnrN8a5=jApsXHdB5Q@mail.gmail.com>
 <abca6ecb-5d93-832f-ff7c-de53bb6203f3@arm.com>
In-Reply-To: <abca6ecb-5d93-832f-ff7c-de53bb6203f3@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 22 May 2020 08:02:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKVyqc9QZhGD7FeNLpJ=x3oLzmY0zADBa+6ZaE46dN39w@mail.gmail.com>
Message-ID: <CAL_JsqKVyqc9QZhGD7FeNLpJ=x3oLzmY0zADBa+6ZaE46dN39w@mail.gmail.com>
Subject: Re: [PATCH 09/12] dt-bindings: arm: fsl: Add msi-map device-tree
 binding for fsl-mc bus
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        PCI <linux-pci@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        linux-acpi@vger.kernel.org,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 22, 2020 at 3:42 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-05-22 00:10, Rob Herring wrote:
> > On Thu, May 21, 2020 at 7:00 AM Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> >>
> >> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >>
> >> The existing bindings cannot be used to specify the relationship
> >> between fsl-mc devices and GIC ITSes.
> >>
> >> Add a generic binding for mapping fsl-mc devices to GIC ITSes, using
> >> msi-map property.
> >>
> >> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >> Cc: Rob Herring <robh+dt@kernel.org>
> >> ---
> >>   .../devicetree/bindings/misc/fsl,qoriq-mc.txt | 30 +++++++++++++++++--
> >>   1 file changed, 27 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> >> index 9134e9bcca56..b0813b2d0493 100644
> >> --- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> >> +++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> >> @@ -18,9 +18,9 @@ same hardware "isolation context" and a 10-bit value called an ICID
> >>   the requester.
> >>
> >>   The generic 'iommus' property is insufficient to describe the relationship
> >> -between ICIDs and IOMMUs, so an iommu-map property is used to define
> >> -the set of possible ICIDs under a root DPRC and how they map to
> >> -an IOMMU.
> >> +between ICIDs and IOMMUs, so the iommu-map and msi-map properties are used
> >> +to define the set of possible ICIDs under a root DPRC and how they map to
> >> +an IOMMU and a GIC ITS respectively.
> >>
> >>   For generic IOMMU bindings, see
> >>   Documentation/devicetree/bindings/iommu/iommu.txt.
> >> @@ -28,6 +28,9 @@ Documentation/devicetree/bindings/iommu/iommu.txt.
> >>   For arm-smmu binding, see:
> >>   Documentation/devicetree/bindings/iommu/arm,smmu.yaml.
> >>
> >> +For GICv3 and GIC ITS bindings, see:
> >> +Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml.
> >> +
> >>   Required properties:
> >>
> >>       - compatible
> >> @@ -119,6 +122,15 @@ Optional properties:
> >>     associated with the listed IOMMU, with the iommu-specifier
> >>     (i - icid-base + iommu-base).
> >>
> >> +- msi-map: Maps an ICID to a GIC ITS and associated iommu-specifier
> >> +  data.
> >> +
> >> +  The property is an arbitrary number of tuples of
> >> +  (icid-base,iommu,iommu-base,length).
> >
> > I'm confused because the example has GIC ITS phandle, not an IOMMU.
> >
> > What is an iommu-base?
>
> Right, I was already halfway through writing a reply to say that all the
> copy-pasted "iommu" references here should be using the terminology from
> the pci-msi.txt binding instead.
>
> >> +
> >> +  Any ICID in the interval [icid-base, icid-base + length) is
> >> +  associated with the listed GIC ITS, with the iommu-specifier
> >> +  (i - icid-base + iommu-base).
> >>   Example:
> >>
> >>           smmu: iommu@5000000 {
> >> @@ -128,6 +140,16 @@ Example:
> >>                  ...
> >>           };
> >>
> >> +       gic: interrupt-controller@6000000 {
> >> +               compatible = "arm,gic-v3";
> >> +               ...
> >> +               its: gic-its@6020000 {
> >> +                       compatible = "arm,gic-v3-its";
> >> +                       msi-controller;
> >> +                       ...
> >> +               };
> >> +       };
> >> +
> >>           fsl_mc: fsl-mc@80c000000 {
> >>                   compatible = "fsl,qoriq-mc";
> >>                   reg = <0x00000008 0x0c000000 0 0x40>,    /* MC portal base */
> >> @@ -135,6 +157,8 @@ Example:
> >>                   msi-parent = <&its>;
>
> Side note: is it right to keep msi-parent here? It rather implies that
> the MC itself has a 'native' Device ID rather than an ICID, which I
> believe is not strictly true. Plus it's extra-confusing that it doesn't
> specify an ID either way, since that makes it look like the legacy PCI
> case that gets treated implicitly as an identity msi-map, which makes no
> sense at all to combine with an actual msi-map.

No, it doesn't make sense from a binding perspective.

>
> >>                   /* define map for ICIDs 23-64 */
> >>                   iommu-map = <23 &smmu 23 41>;
> >> +                /* define msi map for ICIDs 23-64 */
> >> +                msi-map = <23 &its 23 41>;
> >
> > Seeing 23 twice is odd. The numbers to the right of 'its' should be an
> > ITS number space.
>
> On about 99% of systems the values in the SMMU Stream ID and ITS Device
> ID spaces are going to be the same. Nobody's going to bother carrying
> *two* sets of sideband data across the interconnect if they don't have to ;)

I'm referring to the 23 on the left and right, not between the msi and
iommu. If the left and right are the same, then what are we remapping
exactly?

Rob
