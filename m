Return-Path: <linux-acpi+bounces-3886-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16243860823
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Feb 2024 02:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE9442822CD
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Feb 2024 01:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97A28F47;
	Fri, 23 Feb 2024 01:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="A8Jb1eve"
X-Original-To: linux-acpi@vger.kernel.org
Received: from snail.cherry.relay.mailchannels.net (snail.cherry.relay.mailchannels.net [23.83.223.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0391B33EA;
	Fri, 23 Feb 2024 01:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708650815; cv=pass; b=VZvKGJnBW/muHLBAm6n2bGhNWAhkcYAL3FwBvBKp0EjveQMmlmR/qfcgc8Itxa7XB04Szk6t0iI5/jXSDTKr9c0QK95yyLLusMttlf5vXTSFH7uLYk3hTqW3ObikdaBvShGU1CNibJbrZ/a48Rta74Y034WrQOHUcvYiqJsPkr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708650815; c=relaxed/simple;
	bh=mKFXGFHpxOFwq73nT0CzdoEb75f0DuCUlRp626b0U5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Edjsj3ey2IBAUrKGwIR6a0GqYleY6FKO5OPlAeHY5KSDzkZYbLDCrTKSNWYHG0TK2BzNkwgg4hc6QAJ9kZWF91iE53W+6AgAPKXT2q0jwulwmR21QY68E0SRuqLhk/mVx76v616nWuZtOeOP2HvRhHJNT68uFSR1QCGye0UJcmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=A8Jb1eve; arc=pass smtp.client-ip=23.83.223.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 62C043619E3;
	Fri, 23 Feb 2024 01:13:27 +0000 (UTC)
Received: from pdx1-sub0-mail-a236.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id BE64236167F;
	Fri, 23 Feb 2024 01:13:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1708650804; a=rsa-sha256;
	cv=none;
	b=JpyCfBSWLPn/CQcD/bz2Z04wbO78M584h+EYOAQe2uPS+wDrlA7jUgGDc/uLxLgp6facsy
	k/o1HCKvw0oyUxQ6tPQtKfpqigJzrbVNjAeuYZ7pKWQA3lUedQ4BNSnsdc0aG/5pbEcVB1
	s9Rn2/H4M0SvadpxuxK12FTnKFPK+pWn5cEE2/jBQb73zB7zpgg0OKQjFROAsxX90lL0m9
	qJZ1efiOMvgq+qHE/Q/0gYbNziff/q9ZRNhyQlQQKiOeZJdgGQiwilKbrlrmcSQRKq/Qf+
	2q0RNA3ypv59uk53xRoP+ZcJ3IbwRLqFFpqDucAsLlQGx2Jr6iwI1RgMCFvCSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1708650804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=E8pn+w3HibWLdOMz9pQ+J+2lKrcMhmXwK9/XHfbO8Yo=;
	b=Qci2ShCjkn1wqSbexL+ofa9BpdOszoxdiTDsA/ZaeTkBCvpWkmXrMFR0je1pmXX7aTwomY
	a1+O6zoqd2YTYKKkfMqXGTWqy/CwzkWx9zWpXVWuw3OLOqUy0kiNk0ZYmqCuzpG8D/03/e
	aFiUuV2a1Z+Wj3I+6kuhQI2oSj1h+Ad51kuImcasNI4vwiiOV71lWhUNcsBGIjfbTE6/n3
	v2cc11tfEXbCcXYlgbYTnMFY+8xkBajFWsBJ/0KmgittyHbFQuLioJSIQkI/XhcTYl+Xij
	hhTVLTYJs/HdMtu+zHkn2M9Uzu1/m/g7snX2+uhO5+rWsqWgHbASYLkmsmKykw==
ARC-Authentication-Results: i=1;
	rspamd-55b4bfd7cb-w5t9p;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Arithmetic-Abortive: 22a6d8a66356533b_1708650807211_1721313757
X-MC-Loop-Signature: 1708650807211:1808631686
X-MC-Ingress-Time: 1708650807211
Received: from pdx1-sub0-mail-a236.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.112.142.233 (trex/6.9.2);
	Fri, 23 Feb 2024 01:13:27 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a236.dreamhost.com (Postfix) with ESMTPSA id 4TgsTB3R7pzQg;
	Thu, 22 Feb 2024 17:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1708650804;
	bh=E8pn+w3HibWLdOMz9pQ+J+2lKrcMhmXwK9/XHfbO8Yo=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=A8Jb1eveAREnA0NyRAiWRq0vA0ZVB7HVgEKyaCQwEVy/w3E0WadQGYMWeOdrNIL79
	 Tbh4U3dPno+2i4EgW3P1pBwnLl3LuSJDUOUd69XUbT56N6NS5bEneXsl7yKOQ4j88N
	 rMZWVjr0lNV0ykcg1X3blQrALIAxrTWLBufHiyAB6Of+IIYhuSmbZZjpho21SKa30q
	 OT12bp82AWG4kw9eAZ7RuPWbEhOerhPZW6jLhpgOF9mt/HOxs7oHEGOs4jEI/4Fed7
	 SlkleUCIoFYCn18IXlJrvkyHaUNySeRmT+Q276BbkbgeieDTwYhl5lnymDIYMXrxm8
	 07thysYEkPMig==
Date: Thu, 22 Feb 2024 17:13:02 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Ben Cheatham <benjamin.cheatham@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>, jonathan.cameron@huawei.com, 
	rafael@kernel.org, james.morse@arm.com, tony.luck@intel.com, bp@alien8.de, 
	dave@stogolabs.net, dave.jiang@intel.com, alison.schofield@intel.com, 
	vishal.l.verma@intel.com, ira.weiny@intel.com, linux-cxl@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Subject: Re: Re: [PATCH v13 2/4] EINJ: Add CXL error type support
Message-ID: <aitsb65thx4oyojuuf7s4tett5sw7p4qih7hlqqzmahrkdgoqi@akiloc4olwrx>
References: <20240220221146.399209-1-Benjamin.Cheatham@amd.com>
 <20240220221146.399209-3-Benjamin.Cheatham@amd.com>
 <65d63647ecdb1_5e9bf294d6@dwillia2-xfh.jf.intel.com.notmuch>
 <5a650a49-8f80-4ade-8844-61f88172cecd@amd.com>
 <65d65ffdd40f_5c76294ce@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <f308f836-a41c-4de8-8522-7c086d89f167@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f308f836-a41c-4de8-8522-7c086d89f167@amd.com>
User-Agent: NeoMutt/20231221

On Wed, 21 Feb 2024, Ben Cheatham wrote:

>So the way the EINJ module currently works (at least as I understand it)
>is that any address supplied for memory errors is checked to make sure it's
>a "normal" memory address. Looking at the comment above the memory checks:
>
>	/*
>	 * Disallow crazy address masks that give BIOS leeway to pick
>	 * injection address almost anywhere. Insist on page or
>	 * better granularity and that target address is normal RAM or
>	 * NVDIMM.
>	 */
>
>it seems that's the case. What this means is that we can't supply the
>RCRB of a CXL 1.0/1.1 port because it's an MMIO address and we have to disable
>the checks to inject a CXL 1.0/1.1 error.

Maybe worth a comment here as to why the error checking is skipped for cxl?

+	} else if ((type & CXL_ERROR_MASK) && (flags & SETWA_FLAGS_MEM)) {
+		goto inject;

Thanks,
Davidlohr

