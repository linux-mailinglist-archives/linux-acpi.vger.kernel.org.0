Return-Path: <linux-acpi+bounces-20647-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJn3MDqGeGk/qwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20647-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 10:32:42 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EE291C27
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 10:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E058F303607D
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 09:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190182DC762;
	Tue, 27 Jan 2026 09:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zd85Pid8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA45C2D59E8;
	Tue, 27 Jan 2026 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769506202; cv=none; b=j+2eLPKoOw3bbPSPvLDtDhgpq72O8SdAe+81HEWWj0HHbo7FP+Wj5wPjG0ZS65+XRhSHnBOTBmIahKL56u7ZdqBaqgcfIlY11chrNuT9yq5h5XEUzK+rUMf8AuGToURH7cGevmm4JFKEhO0+Y4JrlG9S6X0my8VDTmYbDXr6Cd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769506202; c=relaxed/simple;
	bh=p/aELUAJDL5FGGefcJkRH8xIg2MGXOf7m+Juj3lDsOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaPDHf+mvZbWgWttuy48NQc8e5FW3a7LtirYfPFnqhzlEOJPcq50jgD+66aK0tiPmngBwhMlCkmJ/FyCdNF8/voB3tqEP43+iAV4swJN3c+COWwTfzEwaN7MPROZRz62fnUJ2ehaX88J03AHgjZWQG4zE+og9sid45IECD7SG4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zd85Pid8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2623FC116C6;
	Tue, 27 Jan 2026 09:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769506201;
	bh=p/aELUAJDL5FGGefcJkRH8xIg2MGXOf7m+Juj3lDsOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zd85Pid8aQ8FfqrPQIhIeGBcHux56PncQkFIlpprP3EEKVzWweH6KonUlNfLi9gFL
	 kIzKLn9Xhe6eNi4Ip0ge4E6k8f+GuPM5dAdC6okLi049lYykMifWTg7zP5U5paLS2O
	 tvQ71JkgFyDFJsdxS7nnlBgc8TNDp3yPKUasXf21SZLTMsqC8nTwMj8qs/TYvYeuC+
	 bK/ftzuc1M2Uo6JT7qorkoOkt5mbpLUysfeonSEJ3qSGI9wQji0fMAqLjiz+L62jGJ
	 BwZIS8wWbyBseOJPbeaagUOaYY2Ip7NHmaazC22O7ilLKwOme+cGdqxI5bYrP7LJ3P
	 jaTgSkleOS7+w==
Date: Tue, 27 Jan 2026 09:29:58 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>,
	Adam Young <admiyo@os.amperecomputing.com>,
	Robbie King <robbiek@xsightlabs.com>,
	Huisong Li <lihuisong@huawei.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH 0/6] mailbox: pcc: Refactor and improve initialisation
 and interrupt handling
Message-ID: <aXiFlkKAuV8QSgcM@bogus>
References: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
 <20251127-ancient-baboon-of-opportunity-5f773d@sudeepholla>
 <aWUnZJ83_AKQDagu@bogus>
 <f30ff47e-2bcf-4239-9f56-c624f4978307@amperemail.onmicrosoft.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f30ff47e-2bcf-4239-9f56-c624f4978307@amperemail.onmicrosoft.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,os.amperecomputing.com,xsightlabs.com,huawei.com,arm.com];
	TAGGED_FROM(0.00)[bounces-20647-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 12EE291C27
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 12:07:26PM -0500, Adam Young wrote:
> 
> 
> On 1/12/26 11:55, Sudeep Holla wrote:
> > On Thu, Nov 27, 2025 at 02:40:56PM +0000, Sudeep Holla wrote:
> > > Hi Jassi,
> > > 
> > > On Thu, Oct 16, 2025 at 08:08:14PM +0100, Sudeep Holla wrote:
> > > > This series refines and stabilizes the PCC mailbox driver to improve
> > > > initialisation order, interrupt handling, and completion signaling.
> > > > 
> > > Are you happy to pull these patches directly from the list or do you
> > > prefer me to send you pull request or do you want me to direct this via
> > > ACPI/Rafael's tree. Please advice.
> > > 
> > Hi Jassi,
> > 
> > Sorry for the nag. I did see these patches in -next as well as your
> > v6.19 merge window pull request which didn't make it to Linus tree.
> > However I don't see it -next any longer. Please advice if you want
> > anything from my side so that this can be merged for v6.20/v7.0
> > 
> 
> I thought you had an approach you wanted to implement for the functions that
> provided access to the Mailbox internals: you wanted to do them inline but
> hadn't gotten to them yet.  Is that still the case?  I will resubmit mine as
> is with -next if that is acceptable.
> 

Honestly, it has been a while and I have lost the context. Please post what
you have or thinking of on top of linux-next or jassi's -next and we can start
the discussion fresh.

-- 
Regards,
Sudeep

