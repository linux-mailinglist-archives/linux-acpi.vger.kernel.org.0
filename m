Return-Path: <linux-acpi+bounces-20013-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10073CFF99F
	for <lists+linux-acpi@lfdr.de>; Wed, 07 Jan 2026 19:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FB593104784
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jan 2026 18:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A362350A0E;
	Wed,  7 Jan 2026 18:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpRyVQqe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6597934F486
	for <linux-acpi@vger.kernel.org>; Wed,  7 Jan 2026 18:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767809651; cv=none; b=brwuujLF8G2muqdMkOS4mTfIXccPg6Rt/EmIPa+A4z8j3VQ8J6uy9mmPLwunYOrMmH5EM9qxH5IzpeISH2jSzO1yEt9SNmyLOPmRjkvTsqOnTNshj4Mq8EGOBOyDl+HaCmKBsfJ5GQ+JBW6Vo6GbBe6h87+DYh0YoZcN0eAHgnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767809651; c=relaxed/simple;
	bh=Or6ZJEKCM1DQ+oX49ElTafjLQdHGJmX8pOss1V/kdWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4xHnNMJpSs0P0jb0/A/9VX71oDb3MjU9fYCjvR7EDR/kHz6zE/5Xd3wJIVVPEcsnjf8/3KiV5xkT/hvFdLHO5fU2T1Qa9J49kEeondfG7Ss74uiNGEyhanzyi4azaw8/+X4YZVOeW1oLBb4gDwWD3FJpJSv0EWBxcs6tQw8qN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpRyVQqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFCBC4CEF7
	for <linux-acpi@vger.kernel.org>; Wed,  7 Jan 2026 18:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767809650;
	bh=Or6ZJEKCM1DQ+oX49ElTafjLQdHGJmX8pOss1V/kdWg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QpRyVQqe52aBBb9zrVe2MpxUlwy/kbKrXkFFlMNf+5pyi4qGN9x1Td8FBOrPr55kX
	 wyUP4Oe8o9h1LuaRTDEWvjxiSG6w93G9crYMIoX/+TnZKPGZw4kI1mdaHxJGfOhujI
	 k0obQS9sIJ+ZiYKiFkZ6O9XhFGWLFi9Z4Dy7izKxmteLZCmBMzCZ76sZ8ehRKQ+iXL
	 KW7qvEbaPU2z06K+8/iWnydCJZ91vKHFswJWYrqWTjQiwAiUYGAXqCZ+YQksY6JKry
	 FDc3j4BgHRQCdrTVLT5Y8mV3/+dR0EwTWIha4jx6Qi19DqWwiGogBcMNcmnfCcK3nJ
	 Z6gXJU51r19yw==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3ec46e3c65bso1786414fac.0
        for <linux-acpi@vger.kernel.org>; Wed, 07 Jan 2026 10:14:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV2CWbL/lVTmTxByb1jC+0DZkiYmes7LP+iHQtbCn+emkGd+9zjNjs/Sg+VBLAv0D/GMDcls5ZdAfG+@vger.kernel.org
X-Gm-Message-State: AOJu0YxjtVRGHfvVAt4oP4V5YAdLWtrDqqUN7SWxcQmwKrpixpn3ga65
	E+2oUlDuCiYxyz+79zFALah4V6NBA1it7Tb22zWBShhAXqX2rW3eEv/hTbLzOyBVuMXChMjE7l/
	PBDoLyJZaWwc23tSU3g3BWlv290ErURA=
X-Google-Smtp-Source: AGHT+IFQFfboXe1ofeqeN7BTprvaQHSEdKPyzQ1xSOb+o/SRJ6Ob9srFcSYtEUYh5cJktnzuFPECDtSbWavR1FuObEI=
X-Received: by 2002:a05:6820:1686:b0:659:9a49:8fc8 with SMTP id
 006d021491bc7-65f55085439mr1281374eaf.65.1767809649966; Wed, 07 Jan 2026
 10:14:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205142831.4063891-1-haakon.bugge@oracle.com>
 <D49C0D9C-96F9-4D2A-974C-7B6E0CBFB235@oracle.com> <1C290028-E094-48E3-B2CC-29734CEBC97C@oracle.com>
In-Reply-To: <1C290028-E094-48E3-B2CC-29734CEBC97C@oracle.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 Jan 2026 19:13:58 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hr12dZig=A1sDyDhFN32Yn05Vxd=+q6TuVgzVwurrjsg@mail.gmail.com>
X-Gm-Features: AQt7F2pgIqh6lHiQQ_62cf_60U9QZ-M0USWaCH3gr_Ftj9YTyulO66mTFpEBfA8
Message-ID: <CAJZ5v0hr12dZig=A1sDyDhFN32Yn05Vxd=+q6TuVgzVwurrjsg@mail.gmail.com>
Subject: Re: [PATCH] PCI/ACPI: Do not fiddle with ExtTag and RO in program_hpx_type2
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya <okaya@codeaurora.org>, 
	Casey Leedom <leedom@chelsio.com>, Ashok Raj <ashok.raj@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, dingtianhong <dingtianhong@huawei.com>, 
	Alexander Duyck <alexander.h.duyck@intel.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 6:59=E2=80=AFPM Haakon Bugge <haakon.bugge@oracle.co=
m> wrote:
>
> >
> >
> >> On 5 Dec 2025, at 13:28, H=C3=A5kon Bugge <Haakon.Bugge@oracle.com> wr=
ote:
> >>
> >> After commit 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if
> >> supported"), the kernel controls enablement of extended tags
> >> (ExtTag). Similar, after commit a99b646afa8a ("PCI: Disable PCIe
> >> Relaxed Ordering if unsupported"), the kernel controls the relaxed
> >> ordering bit (RO), in the sense that the kernel keeps the bit set (if
> >> already set) unless the RC does not support it.
> >>
> >> On some platforms, when program_hpx_type2() is called and the _HPX
> >> object's Type2 records are, let's say, dubious, we may end up
> >> resetting ExtTag and RO, although they were explicit set or kept set
> >> by the OSPM [1].
> >>
> >> The Advanced Configuration and Power Interface (ACPI) Specification
> >> version 6.6 has a provision that gives the OSPM the ability to
> >> control these bits any way. In a note in section 6.2.9, it is stated:
> >>
> >> "OSPM may override the settings provided by the _HPX object's Type2
> >> record (PCI Express Settings) or Type3 record (PCI Express Descriptor
> >> Settings) when OSPM has assumed native control of the corresponding
> >> feature."
> >>
> >> So, in order to preserve the increased performance of ExtTag and RO on
> >> platforms that support any of these, we make sure program_hpx_type2()
> >> doesn't reset them.
> >>
> >> [1] Operating System-directed configuration and Power Management
> >>
> >> Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
> >> Fixes: a99b646afa8a ("PCI: Disable PCIe Relaxed Ordering if unsupporte=
d")
> >> Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
> >
> > A gentle ping on this one.
>
> And a re-ping.

And I'm still hoping to receive some feedback from the PCI side on this.

Thanks!

