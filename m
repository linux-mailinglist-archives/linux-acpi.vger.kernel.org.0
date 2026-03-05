Return-Path: <linux-acpi+bounces-21379-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAe+HU7XqGlmxwAAu9opvQ
	(envelope-from <linux-acpi+bounces-21379-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 02:07:26 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7F0209B13
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 02:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6614C30BEE61
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 01:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B34723EA85;
	Thu,  5 Mar 2026 01:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="s4dijsjx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8103B2248AF
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 01:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772672745; cv=none; b=HZFC5Y+K5avWJjY924msvHQOTWgOEJDIxJ2fUnN9WZkXzPtAVw+K5LReCU7slGoI1QG/ti3ChrLuW8HUlMPbguC7+afsulylYPdKw1wR5Dcy2FI/QxJEIjmT7LWu9EN9Uax+ZuCN74Co9j6qzBR6uCwT1IEuJ8SdFieu7PL+3M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772672745; c=relaxed/simple;
	bh=/zKnBOxICMcZw91Ph/QZZ5zni/3oVabpUEVjglg4pqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syjC/aQuEY6Yd0MuQbTaHNialo7/2+TSqT9Hg671u7xvw7G9YrAFlIhRSEIBG+8Q/oN5Z9LwaiK6pmMtxdlZuWdCrnJvoIxu2ZR7UJ05T45G+tJJEmh/67mYp6wq9JucYVSZ3i4f81ifRIzEGxL4rsxVlabwJkPHKW/yVkbyPVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=s4dijsjx; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-89a05955720so45358166d6.2
        for <linux-acpi@vger.kernel.org>; Wed, 04 Mar 2026 17:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772672741; x=1773277541; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b/K8oExowzofbndlmLRvjuXWIIQ5XDDj++/GQGtDPio=;
        b=s4dijsjxaIrX6GT/LC39ZJE+nsJuDK5i2bO34vqW/4OBaCNLrvJGQGrG74BR2oDCpC
         Svzr/qdjuf4ztEUMh81DhufQcjn2etz07Z51rpAmh+tAYWMnxte+8UtMOapzCm5Cd7C3
         VUlUP4rCcNTxUvlwq4wPwHen+QTq7DhgDdxDK5Pq5Q/t05NceW8Ix1MW7x/hqzR2tWIv
         ULL/kd+OBeYfT+0EO3hm7uJ74Ob1jau0Icdy005okdpetNc8s8cI0ySZffkwXuvkV9iR
         g3NseWfeWvsxDtY/9r7h4FMCbMeTVexDdlhN3q7HxAG48/wUb9aeLwQcXDqJv5wgYRVK
         XRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772672741; x=1773277541;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/K8oExowzofbndlmLRvjuXWIIQ5XDDj++/GQGtDPio=;
        b=ULXUUuZRnAbsWput8Hi8RddyzoINqE+E5Hjg6TojPmjl+NK8BuHNLnJv2p9GckV7XG
         IXOvmY1/l159m1xnDZAWACTE/tKkl4Lr/4Tpj169q/OriH7iLPpmA5ZK8U8hlyTB4M3B
         kjf2sDkgpchjD4iBVwWkLdHaZmBgBcut90i85F19FN+SK3KUn5k8tHv3ZHJ+wd/BWvGo
         pgI8/WZWFlY9El/YiOzseyvxuCfGyzIBGgUX4udIZxiueIH1RlD5LFRID35V3SrfuirA
         jOBy4pAaM2MtOAOYk8Lnn0k2Pdcha2Xc68FA+ls8j+jUPkfi/d9v7lqC4v5hfNgHZJdw
         B5Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUxkez04q11JFneqJEsUpAwUfviyqWeiE9PvjJ28r26M2tRQQUXgpF2bbBxYWWe8sHjvqPhS+imYToQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxRqGQ5V3kaE5YV36hpC44neBFVXIfrgiGGdQyXtTBPwTzPfRzt
	CYNI3vesvWFUZ3q9dB6GoCVufW+YxBONRFlfd+ZMyFODX+3szq0kCTASpqt/hUm7CDk=
X-Gm-Gg: ATEYQzwia0/17FQHHS/6qrBn9zd/u35iHdVx4n5ohH+pQQ3Yw+1Ot+BbAc32J8ES7G9
	AEFbQipB1z0L9yLsBcqMQeCcF3QWOTY490U2zV0vCCr3MnfwApKsQd+0eW9lZ+84EqrOU8pzKlf
	A3yXRnSflevzOaNicqVRLDssG1aAxiwATWCFvln/dI3Q4IqJtFosiLNbAGKoVM8z3xkekXB1sAt
	NEz4gFoirn7sZzKYgG5F5jpXScP+W6GBeDZEyC3thmcBHQpozzmbD0l2ZrZkLSLPzCHwGUckLE1
	ovFNnN3qI16gZfhYIjoYa/q/kPDOvpkUmUcm75y7XRy0xO90YJC+BJQuWcMpK13AV9UA14MMCsr
	v+P7lII2Qdbb/Y6WcBZer8EzIH0EygzNoRr6T+TOnd2mxtQFZY9wp8Ij2X93OGrQMSBnAnaVYDw
	dS1w+dyzdPXnWiem/dhunDYUr1q5yFhFFHEy4Mj55vbAELy2+PeTRSbQhWLtLqiwdSi4Q0JqgS7
	m6daqww5g==
X-Received: by 2002:a05:6214:411e:b0:89a:170b:a6f6 with SMTP id 6a1803df08f44-89a19aee4d7mr54977276d6.37.1772672741289;
        Wed, 04 Mar 2026 17:05:41 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899fc21676fsm81448586d6.22.2026.03.04.17.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 17:05:40 -0800 (PST)
Date: Wed, 4 Mar 2026 20:05:38 -0500
From: Gregory Price <gourry@gourry.net>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"Schofield, Alison" <alison.schofield@intel.com>,
	"thorsten.blum@linux.dev" <thorsten.blum@linux.dev>,
	"wangyuquan1236@phytium.com.cn" <wangyuquan1236@phytium.com.cn>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Message-ID: <aajW4lDhuvoQ1nWF@gourry-fedora-PF4VCD3F>
References: <20260304213342.5776-1-kai.huang@intel.com>
 <aaizNh-0LEvRQMCy@gourry-fedora-PF4VCD3F>
 <aai-K2tEdIp5B4XP@aschofie-mobl2.lan>
 <aajGuOC-G_dFYpwa@gourry-fedora-PF4VCD3F>
 <4809035f61dcd6ace773532efe46b0f1928be313.camel@intel.com>
 <aajOckpcmQwYydVQ@gourry-fedora-PF4VCD3F>
 <178a85c1d5a48938bf866a85d34ee2ba87901d10.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178a85c1d5a48938bf866a85d34ee2ba87901d10.camel@intel.com>
X-Rspamd-Queue-Id: DB7F0209B13
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21379-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[gourry.net:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry.net:dkim,gourry.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 12:45:39AM +0000, Huang, Kai wrote:
> > 
> > You are taking something away by nature of compiling something out by
> > default that was previously not compiled out by default.
> 
> Yeah, and it is due to "there's a cost" if we don't compile out by default.
> 
> Hope that justifies?

Sorry, i don't mean to come off rough - I don't even necessarily
disagree with the change here, but it is worth taking a moment to
understand whether this is actually a Linux issue or an platform issue.

Up until now there's been some assumption that if a device is attached
there will be CEDT windows - but this would be the first time i've seen
a platform throw up CEDT windows for devices that don't exist.

Anyway, this is good information for Linux to know and worth a comment.
We don't know what other people have built that depend on the current
behavior.

> > 
> > Well, I'm mostly confused why there are CEDT entries for hardware that
> > presumably isn't even there - unless this platform is reserving space
> > for future hotplug.  
> > 
> 
> I think this should be the case.
>

If that's the case then cool :]

May be worth a comment in acpi_numa_init_cxl - something like:

/*
 * Some platforms report CEDT CFMWS for hotplug device support. These
 * windows are unusable without CXL drivers, so don't reserve fake nodes
 * if they're compiled out - it wastes memory on per-node structures.
 */

Reviewed-by: Gregory Price <gourry@gourry.net>

~Gregory

