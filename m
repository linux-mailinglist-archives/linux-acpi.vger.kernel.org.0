Return-Path: <linux-acpi+bounces-21372-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOBbDejGqGm9xAAAu9opvQ
	(envelope-from <linux-acpi+bounces-21372-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 00:57:28 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C51DD20942F
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 00:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A82E43063AFE
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 23:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8AD39F17C;
	Wed,  4 Mar 2026 23:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="oCiDkoZT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA31D390CBA
	for <linux-acpi@vger.kernel.org>; Wed,  4 Mar 2026 23:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772668606; cv=none; b=ZjXwd3j1XwXBOUTNo6QUD2uqHmCA9b4ulkAJXdsDtDrNAf3k7KfQRGlKaN6Obuzdj5rJvWy33G0JRblPQxvlvo2KOD2CUv+CsMZtP5FtKZCnBYdTTORxwKcBvOgT3fOecBMVRxNO478eQwHNdOE7iK/8/ETAFZHw4W+V5Rh2G4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772668606; c=relaxed/simple;
	bh=Giw3/067GrNgQbtrZLaDCpoqSBeafl6A+nGzlEidTog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vp0F9fIxe6LMWV0B5aob24JwOWMWz1LmjrUbCe9E31g8df02troW+WDVYfgHZs1c5ryP+zS8ND+UEBQjf1+vUHJ1zx5TXbJhX43t0DdXLeSS8W0LxPBC5mMw8sfgOe5PiYnarKFhAiurdDDDkLX0WY3S63j2X22it5Cg3pKqYg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=oCiDkoZT; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-899e85736e2so45818096d6.1
        for <linux-acpi@vger.kernel.org>; Wed, 04 Mar 2026 15:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772668603; x=1773273403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dpj9qG8Bv81Wer9VtkXzUxrZr6VBH25/Zpz3n0Y4DLM=;
        b=oCiDkoZTqsg4uUrW/LBZ4m6EqOVlTY6fHZu5kNdxmZMM3fs/mlcwUv2kW8LMw7Faud
         93v02w3cK9twv+4COFVEQb+yZ9x5mEVH8oXcE6bFC37ziEvFC1LN/7RqOaE9KriQkgY8
         oZ2Uh1RzjxXLVE5Hku2JMhWBFhqi9Ih4D46IKvzn6oZbfyrui58jwsv5WXRrnuft24i/
         8drMCphlfdIQ4bBJBL9NNMoLDCq/LoyhxU4ACafDowh28dOzUS68r3Ng8F+0o438HNUa
         5fkuZNn/AgMR0vgF9kcUSX2NKyEAScoLHf+baGkQvUO9Cz9KYtGTC2yz4D60Z3OP64J+
         tr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772668603; x=1773273403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpj9qG8Bv81Wer9VtkXzUxrZr6VBH25/Zpz3n0Y4DLM=;
        b=kNsYt6JGeZPLY2ekO9je3W0sdBUhtUdGRIsWs7GRCGbQV42t3/a1U6cRtiVUHbEFfd
         dGS1kPVHy69HhNwFw/OsMl6BcTmNIC/CaTFk37SbO0XMFP8ewXWgF/NWja8enMurMs9j
         5R9uQ2aupOHcCSantWtfP5wMRctmiHn1Xi49NwkcYlZloQ06wko9bXIhVcqoye46CMjg
         4/g9s0KmjqCIGc80ZcUsyDooX19MQ1k5nPyzMQa/O/qeOpXvHdx9moMkcIP0MDVjkyOJ
         KO2tefHFHlgh3EPuCubBMltu7zFZ8gQkot9Dzg/G13egw41YRgKDX/6mIhZkTYKjvEu3
         qvoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj/XgIh7w0U637Ew6KPSj2uhasOF1xy/Tq5lJbeiBeb6OLxUnC+4TYuxe/DFTpLLMbpTqieQzaoxxd@vger.kernel.org
X-Gm-Message-State: AOJu0YwY6ZWD+cNziL40rlcXDEyWEF2BAh+5IZV1qBnbhRfQnPuG7PwU
	i9jBz84eNswFMeaho4jH+AI43K09E8TnytVM9mQkV6ptAThfVniu4Q0EWd6S7ri4zD8=
X-Gm-Gg: ATEYQzyFsx6sJdA45sY++C07Nuc4fDZEH/OVhQW789F8cBoyHChszkrrwMMSo5EnC1z
	Brxsz1bO5xcmLnabH+Bxj7R6MXmK5OlztWbQNHShIKK+zYxLvQLzeYBMtGZ5FDLdCitqBBQWn3F
	NsujYJG8SZWZuJZFQRwF+QgfTeu487TB6v5HeG2mVqkLzt3Hck+1mZAYw4jIURI8+aMfzXOG2PK
	kVIS72JYL6YHmKvO/CYKeAdwyK37VRabdD6OigK4VogAEql7EMmxZkU/zgO6uo0dURXHkjs/QTf
	oJiAqbANxdhqKkM7Z1l+Lx8JyC5mBdzDKPQv+uBj0KNo1JwyJgvsLzUqcdllNJULppDipDEU0Uo
	9sIfhV9hY1PKGeDLB1CLi3GlGJUg1HLSSMSkmRKfnhTld7rOORYbk36PHnDkU5HpkjEVeelnwtP
	mzM+tGkU8OQ9fNicSngNrCHuDkbVSY0meZZp1i7TqJDtNmS6ytEaYtLdcTG4kyyvCw/7fmxPthJ
	mfrfdX2YQ==
X-Received: by 2002:a05:6214:20a8:b0:899:e8b8:504c with SMTP id 6a1803df08f44-89a2490cb15mr6076996d6.30.1772668603583;
        Wed, 04 Mar 2026 15:56:43 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507449630b6sm186648081cf.7.2026.03.04.15.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:56:42 -0800 (PST)
Date: Wed, 4 Mar 2026 18:56:40 -0500
From: Gregory Price <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Kai Huang <kai.huang@intel.com>, rafael@kernel.org, lenb@kernel.org,
	dan.j.williams@intel.com, akpm@linux-foundation.org,
	nunodasneves@linux.microsoft.com, xueshuai@linux.alibaba.com,
	thorsten.blum@linux.dev, wangyuquan1236@phytium.com.cn,
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Message-ID: <aajGuOC-G_dFYpwa@gourry-fedora-PF4VCD3F>
References: <20260304213342.5776-1-kai.huang@intel.com>
 <aaizNh-0LEvRQMCy@gourry-fedora-PF4VCD3F>
 <aai-K2tEdIp5B4XP@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aai-K2tEdIp5B4XP@aschofie-mobl2.lan>
X-Rspamd-Queue-Id: C51DD20942F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21372-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gourry.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gourry.net:dkim]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 03:20:11PM -0800, Alison Schofield wrote:
> On Wed, Mar 04, 2026 at 05:33:26PM -0500, Gregory Price wrote:
> > On Thu, Mar 05, 2026 at 10:33:42AM +1300, Kai Huang wrote:
> > > Increasing the 'nr_node_ids' has side effects.  For instance, it is
> > > widely used by the kernel for "highest possible NUMA node" based memory
> > > allocations.  It also impacts userspace ABIs, e.g., some NUMA memory
> > > related system calls such as 'get_mempolicy' which requires 'maxnode'
> > > not being smaller than the 'nr_node_ids'.
> > > 
> 
> > 
> > Is this a Linux issue or a Firmware issue?
> 
> IIUC BIOS creates the CEDT based on the hardware it 'sees' as present.
> 
> This patch is describing the case (weird as it seems to me) where we
> then boot a system with ACPI and NUMA enabled but CXL_ACPI disabled.
> 
> So, I don't think we can blame BIOS.
> 
> > 
> > Is GNR exporting more CFMWS than it should?
> Not sure of any limits on flavors of CFMWS's a BIOS can offer.
> If BIOS can carve out a window, it can create a CFMWS.
> Not clear how that matters to the issue.
> 
> > 
> > Is your SRAT missing entries for CFMWS that are otherwise present?
> > 
> > Are the CFMWS empty? (is that even valid)
> 
> Why this line of questioning ;)  I see the problem as a bit simpler.
> We have other code that tells us if the CFMWS's are valid, etc, but
> the point here is, we are not going to use these CFMWS's so stop
> the parse as early as possible, like right here as Kai has done.
> 

Mostly i'm wondering if this issue should be dealt with in the acpi code
or if the issue is that we just don't want to figure out how to
lazy-create these things instead of always creating them at __init.

it does seem rational to build out support for CEDT entries if CXL_ACPI
is built out, but this also means you can't otherwise load modules that
would have made use of this information.

This basically says if specifically CXL_ACPI is built out, the NUMA
structure is forever lost - even though it's accurately described by
BIOS.  Maybe that's a rational decision, just kind of prodding a bit.

~Gregory

