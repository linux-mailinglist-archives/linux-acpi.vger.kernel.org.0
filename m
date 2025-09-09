Return-Path: <linux-acpi+bounces-16530-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4F4B4AB08
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 13:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34AE81C62506
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 11:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7912ED16D;
	Tue,  9 Sep 2025 11:02:30 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1D8366;
	Tue,  9 Sep 2025 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415750; cv=none; b=PEsc7fnbca5tw/G1elLOd7xBG8JmRnxCQtwFZwCgws8mMKllkdagx6IxCNeQQGyGEHYbYURTn1+xiL7XVDK5ZflHHLYmgb3+t0YtUvtXwj1R9tQEtFicseGHXfIr39fXBm9wPRUs0jQJ4fRYZ1dFZQrYMdtZ5JHij++yRzbruvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415750; c=relaxed/simple;
	bh=WtAfe/jd/YqfqJ7tJAnEy1Mmd8laQThPeKclnfCzHzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjG1/iiYZ6fUDEsV1dhH8ng9D0p2IyeE7ZX7yQP5UAUiZnUwa2Oj2H7pX0DDxMNC/E/UcD2rV2Evfpbpw+Lfqd6uQYhjUit3jVf+ENgAxqg+4gXxEfgT/oHjidyTyJRHNryTL94dr/eDkeLpG4CsJBQvHtb/9PSAG4CD7uahl50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 906F712FC;
	Tue,  9 Sep 2025 04:02:18 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 548A13F63F;
	Tue,  9 Sep 2025 04:02:21 -0700 (PDT)
Date: Tue, 9 Sep 2025 12:02:18 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: James Morse <james.morse@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>, Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
	baisheng.gao@unisoc.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
	Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 09/33] dt-bindings: arm: Add MPAM MSC binding
Message-ID: <aMAJOghPhaKu1hO+@e133380.arm.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-10-james.morse@arm.com>
 <aK8w1L3gHBk2Fz1k@e133380.arm.com>
 <96827d9f-cea8-4ca3-b709-1ae09e3d901c@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96827d9f-cea8-4ca3-b709-1ae09e3d901c@arm.com>

Hi,

On Fri, Sep 05, 2025 at 10:11:03AM +0100, James Morse wrote:
> Hi Dave,
> 
> On 27/08/2025 17:22, Dave Martin wrote:
> > On Fri, Aug 22, 2025 at 03:29:50PM +0000, James Morse wrote:
> >> From: Rob Herring <robh@kernel.org>
> >>
> >> The binding is designed around the assumption that an MSC will be a
> >> sub-block of something else such as a memory controller, cache controller,
> >> or IOMMU. However, it's certainly possible a design does not have that
> >> association or has a mixture of both, so the binding illustrates how we can
> >> support that with RIS child nodes.
> >>
> >> A key part of MPAM is we need to know about all of the MSCs in the system
> >> before it can be enabled. This drives the need for the genericish
> >> 'arm,mpam-msc' compatible. Though we can't assume an MSC is accessible
> >> until a h/w specific driver potentially enables the h/w.
> 
> > I'll leave detailed review to other people for now, since I'm not so up
> > to speed on all things DT.
> 
> Me neither!
> 
> 
> >> diff --git a/Documentation/devicetree/bindings/arm/arm,mpam-msc.yaml b/Documentation/devicetree/bindings/arm/arm,mpam-msc.yaml
> > 
> > [...]
> > 
> >> @@ -0,0 +1,200 @@
> > 
> > [...]
> > 
> >> +title: Arm Memory System Resource Partitioning and Monitoring (MPAM)
> >> +
> >> +description: |
> >> +  The Arm MPAM specification can be found here:
> >> +
> >> +  https://developer.arm.com/documentation/ddi0598/latest
> >> +
> >> +maintainers:
> >> +  - Rob Herring <robh@kernel.org>
> >> +
> >> +properties:
> >> +  compatible:
> >> +    items:
> >> +      - const: arm,mpam-msc                   # Further details are discoverable
> >> +      - const: arm,mpam-memory-controller-msc
> > 
> > There seems to be no clear statement about how these differ.
> 
> It's a more-specific compatible, I think these are usually things like:
> | compatible = "acme,mega-cache-9000", "arm,mpam-msc"
> 
> Where the driver can key errata-workaround on the vendor specific bit when needed.
> 
> In this case - I think they're examples, but Rob said they were supposed to be in some
> other list of compatible. (not sure what/where that is)

I guess I'll defer to the DT folks about how this ought to be presented.

The DT bindings are a weird hybrid of informal and formal that I'm not
really used to.

> >> +  reg:
> >> +    maxItems: 1
> >> +    description: A memory region containing registers as defined in the MPAM
> >> +      specification.
> 
> > There seems to be no handling of PCC-based MSCs here.  Should there be?
> 
> That is newer than this document. On DT platforms PCC is spelled SCMI, and is
> discoverable. Andre P prototyped this, (patches in the extras branch) but no-one
> has come out of the woodwork to say they actually need it yet.
> 
> ACPI PCC is a definite maybe.
>
> > If this can be added later in a backwards-compatible way, I guess
> > that's not a problem (and this is what compatible strings are for, if
> > all else fails.)
> > 
> > An explicit statement that PCC is not supported here might be helpful,
> > though.
> 
> I'm pretty sure its discoverable on DT/SCMI platforms.

OK.  If this may not be needed, is discoverable and/or can be bolted on
in a compatible way later, I guess we wouldn't need to panic about it
just now.

(At least we can do that much more easily than promulgating an update
to the ACPI tables.)

> >> +  interrupts:
> >> +    minItems: 1
> >> +    items:
> >> +      - description: error (optional)
> >> +      - description: overflow (optional, only for monitoring)
> >> +
> >> +  interrupt-names:
> >> +    oneOf:
> >> +      - items:
> >> +          - enum: [ error, overflow ]
> >> +      - items:
> >> +          - const: error
> >> +          - const: overflow
> > 
> > Yeugh.  Is this really the only way to say "one or both of foo"?
> > 
> > (I don't know the answer to this -- though I can believe that it's
> > true.  Perhaps just not describing this property is another option.
> > Many bindings seem not to bother.)
> > 
> >> +
> >> +  arm,not-ready-us:
> >> +    description: The maximum time in microseconds for monitoring data to be
> >> +      accurate after a settings change. For more information, see the
> >> +      Not-Ready (NRDY) bit description in the MPAM specification.
> >> +
> >> +  numa-node-id: true # see NUMA binding
> >> +
> >> +  '#address-cells':
> >> +    const: 1
> >> +
> >> +  '#size-cells':
> >> +    const: 0
> >> +
> >> +patternProperties:
> >> +  '^ris@[0-9a-f]$':
> > 
> > It this supposed to be '^ris@[0-9a-f]+$' ?
> 
> Looks like yes. Fixed.

OK

> > Currently MPAMF_IDR.RIS_MAX is only 4 bits in size and so cannot be
> > greater than 0xf.  But it is not inconceivable that a future revision
> > of the architecture might enable more -- and the are 4 RES0 bits
> > looming over the RIS_MAX field, just waiting to be used...
> > 
> > (In any case, it feels wrong to try to enforce numeric bounds with a
> > regex, even in the cases where it happens to work straightforwardly.)
> > 
> >> +    type: object
> >> +    additionalProperties: false
> >> +    description:
> >> +      RIS nodes for each RIS in an MSC. These nodes are required for each RIS
> > 
> > The architectural term is "resource instance", not "RIS".
> > 
> > But "RIS nodes" is fine for describing the DT nodes, since we can call
> > them what we like, and "ris" is widely used inside the MPAM driver.
> 
> 
> > People writing DTs should not need to be familiar with the driver's
> > internal naming conventions, though.
> 
> What about the architecture's name for fields?
> This number goes in MPAMCFG_PART_SEL.RIS.

That's the identifier for the resource instance (= "Resource Instance
Selector", see e.g., ARM IHI 0099A.a Section 9.4.14 "MPAMCFG_PART_SEL,
MPAM Partition Configuration Selection Register").  The way I read this,
the contents of MPAMCFG_PART_SEL.RIS is just a numeric identifier
identifier, rather than the thing being identified.

(I guess I am bikeshedding, here.  The chance for actual confusion
remains low.  I just find this use of "RIS" a bit dissonant.)

> > (There are other instances, but I won't comment on them all
> > individually.)
> > 

> >> +      implementing known MPAM controls
> >> +
> >> +    properties:
> >> +      compatible:
> >> +        enum:
> >> +            # Bulk storage for cache
> > 
> > Nit: What is "bulk storage"?
> 
> Probably to distinguish it from other storage a cache may have, such as tag-ram.
> 
> > The MPAM spec just refers to "cache" or "cache memory".
> 
> I figure these are comments, I'll remove them...
> 
> 
> >> +          - arm,mpam-cache
> >> +            # Memory bandwidth
> >> +          - arm,mpam-memory

I think that the meaning of "mpam-cache" is pretty obvious without
benefiting from a comment, but "mpam-memory" is not an obvious name for
memory _bandwidth_.  That probably still wants clarification.

> >> +
> >> +      reg:
> >> +        minimum: 0
> >> +        maximum: 0xf
> >> +
> >> +      cpus:
> >> +        description:
> >> +          Phandle(s) to the CPU node(s) this RIS belongs to. By default, the parent
> >> +          device's affinity is used.
> >> +
> >> +      arm,mpam-device:
> >> +        $ref: /schemas/types.yaml#/definitions/phandle
> >> +        description:
> >> +          By default, the MPAM enabled device associated with a RIS is the MSC's
> > 
> > Associated how?
> 
> By the phandle this is a description for.
> 
> 
> > Is this the device where the physical resources managed by the MSC are located?
> 
> Yes,

OK, that's not "associated by the phandle".  It's a physical hardware
property.

[...]

> >> +examples:
> >> +  - |
> >> +    L3: cache-controller@30000000 {
> >> +        compatible = "arm,dsu-l3-cache", "cache";
> >> +        cache-level = <3>;
> >> +        cache-unified;
> >> +
> >> +        ranges = <0x0 0x30000000 0x800000>;
> >> +        #address-cells = <1>;
> >> +        #size-cells = <1>;
> >> +
> >> +        msc@10000 {
> >> +            compatible = "arm,mpam-msc";
> >> +
> >> +            /* CPU affinity implied by parent cache node's  */
> > 
> > "node's" -> "nodes".
> > 
> > (or it this supposed to be in the singular -- i.e., the immediately
> > parent cache node only?)
> 
> The MSC's parent cache node can be used to find the affinity.
> I'll make it singular and drop the 's

OK

> > Anyway, it looks like this is commenting on the "reg" property, which
> > doesn't seem right.
> > 
> > Is this commnent supposed instead to explain the omission of the "cpus"
> > property?  If so, that should be made clearer.
> 
> 
> I'll move it to the end of the list of properties so it doesn't look like it belongs to
> the one below it.

Ack, that works.

Cheers
---Dave

