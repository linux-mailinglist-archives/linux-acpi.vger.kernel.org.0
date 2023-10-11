Return-Path: <linux-acpi+bounces-590-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B277C5404
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Oct 2023 14:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB54281CD9
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Oct 2023 12:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971EE1F17E
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Oct 2023 12:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YIjUXdrv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZOhzBjNv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC3B15481
	for <linux-acpi@vger.kernel.org>; Wed, 11 Oct 2023 12:06:14 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30317A4;
	Wed, 11 Oct 2023 05:06:10 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1697025969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e8PMcuYySmTK2GLGzDl7ickSIL5xZv3CLwffGGkD0iM=;
	b=YIjUXdrvRneuXFgc7gq7Rn4OY3r/Caz1QfO/PDv0g1CxSKzy/JObsngmnPSIL5InPiL5wb
	oZfTjPtiVApWl+yNCYR6qGxu1NhdHl264HE+q4etwtvlceDSzsK55ijK/8fKVymicPDUvr
	PeBukGq/h+e/CxmKXPHaeCzDULMVqJcu2htT4ul+cAH4Vg8ld6Q2seATPdoZs5harGwQAE
	5FI+Y6qwsG1KaGYooyqLdICL2aI+YhN95XDjvvrZ6rZaSYk/Lv2DD4XZI0WWuQGEGEH5qi
	scUiHjHYSC+sTvAbciNbgwzE3/aMU0B/0FnDkIysRRdzAoOS+eh6+x9yZwl//A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1697025969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e8PMcuYySmTK2GLGzDl7ickSIL5xZv3CLwffGGkD0iM=;
	b=ZOhzBjNvuXO9xiRWpa7Tdwnq7GT1Qfbi1aZb6EEWC5hCIlDewkaxbXXyrQaiE4o1EynyFn
	IL9wQ8L8YD+6czAw==
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, Linus Torvalds
 <torvalds@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, James Morse <james.morse@arm.com>,
 loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com,
 justin.he@arm.com, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, Salil Mehta
 <salil.mehta@huawei.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
 <peterz@infradead.org>, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] cpu-hotplug: provide prototypes for arch CPU registration
In-Reply-To: <ZSV6i4pnjQqvWuKp@shell.armlinux.org.uk>
References: <E1qkoRr-0088Q8-Da@rmk-PC.armlinux.org.uk>
 <ZSV6i4pnjQqvWuKp@shell.armlinux.org.uk>
Date: Wed, 11 Oct 2023 14:06:08 +0200
Message-ID: <87o7h5l5xr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10 2023 at 17:23, Russell King wrote:
> Okay, I give up. 15 days, still no real progress. I don't see any point
> in submitting any further patches for the kernel outside of those areas
> that I maintain. Clearly no one cares enough to bother (a) properly
> reviewing the patch, (b) applying the patch that Thomas thought
> "makes tons of sense."
>
> If patches that "makes tons of sense" just get ignored, then what does
> the future of the kernel hold? Crap, that's what, utter crap.
>
> As I said, it seems that the Linux kernel process is basically totally
> broken and rotten. If a six line patch that "makes tons of sense" can't
> be applied, then there's basically no hope what so ever.

Oh well. I usually try to keep track of such stuff, but this one fell
through the cracks.

Shit happens and we are all human, no?

Sorry for the wrong information about ia64. The removal did not happen
because someone stepped up as a possible maintainer.

Thanks,

        tglx

