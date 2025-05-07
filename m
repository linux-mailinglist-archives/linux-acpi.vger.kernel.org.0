Return-Path: <linux-acpi+bounces-13577-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55296AADFC7
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 14:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5111D7B4178
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 12:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112A52820A4;
	Wed,  7 May 2025 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gU49hi2j"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B41281371;
	Wed,  7 May 2025 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746622255; cv=none; b=VOsqd5qzKIs7ymHqbKi//lHQ1eSzdVrLNVRs6ny0WdSySR6xnphN1WNRDnS+TE4AZlDvutLOa2seGwHtkscCGDzhGr9wx0Srn0/oK1ZCDJRwETGRl3aj7398LAnEzMb3KFMyxsjcw7s2XBMcrb7LBpFNC5QZhTHjOIVVY5+nBKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746622255; c=relaxed/simple;
	bh=b1G2u+a+inYCaY+eHIEk0cQL6kHNdGLIvEIfV2JMKi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/WGwfxcOK72daXAcT6AaUX5hMU3Rsihfa34BX0wYe4yYjnTLpknSDlJYSERVMBvF+xwF8IEUXduGgMtG3eejr3UT28GXokWApyEEJwmQ3ynX4KZWmBqPQO19wFFR3hLEQD2dLLcyVmfUmpsW+0gKrOwyTJTWFauMijqvWm39dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gU49hi2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57263C4CEEE;
	Wed,  7 May 2025 12:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746622254;
	bh=b1G2u+a+inYCaY+eHIEk0cQL6kHNdGLIvEIfV2JMKi4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gU49hi2jL5p4VXYz4uWi5uGl3jq+N5T3C5ISRKEEY/UU4NGS/PXYTYCZYvKkiV5bG
	 RiKbv2TiuTaiQAD+/Y7ChIgroVQH3QmnTnzzCgMp/a+3Jxtby8rIQ1icbU6D+vygUB
	 ZynI2yuBEylNfiy+zE6NxquApun1RIaumWdyjG1uAM84mcoU3DCB3qwQFD1dZUujPp
	 KIKkU1dTiiZDcYSGSbhutARpAk7XN0obIJuU/S+jIrot1C0pdKGrGjgYvY7i2ZB1CM
	 X6py7sVMymHy/BQgzCESb5ql4CNOEkgaXc3y7V75zbkfuxBdcwENi02xcVeZOK20f1
	 YPHj9swTDxMmg==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2db78ef7f69so65797fac.1;
        Wed, 07 May 2025 05:50:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU67oQHdpLSBzzVsqL8HFXDkRqtucdbyjCZdJBm36TSnF6s2a7db2DCo+hUYNFBNODv8zStamRX4HGa@vger.kernel.org, AJvYcCWGmJHwDJqZ327kcevtkE4iU2DE6UMhFSFoPLMwxd/LuGiYBb3Do8N4ayRs99UPjtnzDSOPp0eVQTaG0Spw@vger.kernel.org, AJvYcCX0OHHTak00el1T+9FM0H0nvAZNQvYzmKdBIc18RtVgc6/7ssnq9ZKXeFSRiYgfYPl6maD0bO9A@vger.kernel.org
X-Gm-Message-State: AOJu0YxFcYvkw+kb7CX79oTqfTUSuuIRSec9af6o1w59r4u8TxOgkWNO
	nOxf/4fIm3HqcKg9xhe22Dmiri64VoAO6WbyQfOgnXWXAb7Mt+Zs0KwkjTF6GA1oKT0wdqQh7St
	/xtVZGeqLx4omDz2Iq/kwUllvNRM=
X-Google-Smtp-Source: AGHT+IH7rwQNr5/aN9Cx6BnHDCYku8kKjDXsfS4VXQ0UX97SKFw4eRqCEFsP/fUl0OWL3tX9yRsRyYJE+8H8yLNAbbM=
X-Received: by 2002:a05:6870:9624:b0:29e:2594:81e with SMTP id
 586e51a60fabf-2db5be28df8mr1564064fac.13.1746622253594; Wed, 07 May 2025
 05:50:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506-draco-taped-15f475cd@mheyne-amazon> <20250506-shapeless-merciful-inchworm-7bfdb4@sudeepholla>
 <20250506-dialog-57th-c4e70064@mheyne-amazon> <20250507-mysterious-emu-of-fertility-951c69@sudeepholla>
 <20250507-blend-revel-3d94099b@mheyne-amazon> <20250507-quantum-solid-ibex-218f1b@sudeepholla>
 <20250507-autumn-phrase-4a1eddef@mheyne-amazon>
In-Reply-To: <20250507-autumn-phrase-4a1eddef@mheyne-amazon>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 14:50:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jawX-4QaZG56DK6Urxrh1DMEGi7jKhm=pE1YAwUXBUqg@mail.gmail.com>
X-Gm-Features: ATxdqUEAUAgtd-clsENEBuwV8eDUunmOwf33dlqZ1M-gzGb-mBl9ODBC3X-5bL4
Message-ID: <CAJZ5v0jawX-4QaZG56DK6Urxrh1DMEGi7jKhm=pE1YAwUXBUqg@mail.gmail.com>
Subject: Re: [PATCH] ACPI/PPTT: fix off-by-one error
To: "Heyne, Maximilian" <mheyne@amazon.de>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Jeremy Linton <jeremy.linton@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 2:42=E2=80=AFPM Heyne, Maximilian <mheyne@amazon.de>=
 wrote:
>
> On Wed, May 07, 2025 at 01:30:53PM +0100, Sudeep Holla wrote:
> > On Wed, May 07, 2025 at 11:56:48AM +0000, Heyne, Maximilian wrote:
> > > On Wed, May 07, 2025 at 12:52:18PM +0100, Sudeep Holla wrote:
> > > >
> > > > Just to understand, this node is absolutely processor node with no
> > > > private resources ? I find it hard to trust this as most of the CPU=
s
> > > > do have L1 I&D caches. If they were present the table can't abruptl=
y end
> > > > like this.
> > >
> > > Yes looks like it. In our case the ACPI subtable has length 0x14 whic=
h is
> > > exactly sizeof(acpi_pptt_processor).
> > >
> >
> > OK, this seem like it is emulated platform with no private resources as
> > it is specified in the other similar patch clearly(QEMU/VM). So this
> > doesn't match real platforms. Your PPTT is wrong if it is real hardware
> > platform as you must have private resources.
> >
> > Anyways if we allow emulation to present CPUs without private resources
> > we may have to consider allowing this as the computed pointer will matc=
h
> > the table end.
>
> Is there a need by the ACPI specification that the Cache information
> must come after the processor information? Because on our platform there
> is Cache and it's described but at a different location seemingly. It
> looks like caches are described first and then the CPUs.
>
> I can try to drill even deeper here if you insist. As said I'm no
> subject matter expert here. But is there something obviously wrong with
> my patch or would it be ok to just take it?

The code changes are fine, but the changelog is somewhat misleading.

The problem is that the original code assumed the presence of private
resources at the end of every CPU entry, but in practice (due to
emulation or otherwise) there are entries without them and if such an
entry is located at the end of the table, it will not pass the sanity
check after commit 2bd00bcd73e5.  This issue was not evident
previously because the code didn't work as designed.

