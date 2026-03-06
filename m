Return-Path: <linux-acpi+bounces-21478-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMzwMy6cqmnPUQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21478-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 10:19:42 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F9321DC98
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 10:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4FCC3041390
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 09:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463C133CE92;
	Fri,  6 Mar 2026 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCU+846a"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2325C293C42
	for <linux-acpi@vger.kernel.org>; Fri,  6 Mar 2026 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772788690; cv=none; b=YGi6Ooaceb4x2wpAbx5FxIzC0V46v82sYcHZ+d2UmQyYh4hEHVDCGz4ELRInVcsRBVZ9HzWwrhdEOq7ggCCLaVj+VwuhRgV3eh9pnYR9HyH0Gcbsrsjzsp8doOhFPeOOiMOZ68mC7BU974P3ap0gF9qr9P+cAmaS+TlfPWiPwOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772788690; c=relaxed/simple;
	bh=qkmK+8r0Vh0R6fDkHVizxyGoocw6uaxy7mjtQDWfsWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+FJntg6zQUh+D0Cu5My8OPq2dswTo/KrMHWpiIeWz/LAKr8JuJ533mtv36mmvw0O8+Z36xrZW8Ryb8sE6YmbMsYayP/NqPJp3ObIL4C14TVRD233NYibbFMsgNLKxcZFvabGWUbl+DkVT82YkNUvzBEdBbIoHLY6AHG5Pvu+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCU+846a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF496C4CEF7;
	Fri,  6 Mar 2026 09:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772788689;
	bh=qkmK+8r0Vh0R6fDkHVizxyGoocw6uaxy7mjtQDWfsWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YCU+846aSocm+1jxgEUwegVMu4fvyOI3Yf6YLxnShOMWw7OWNNW+EzTtpgWMSTzlG
	 zJ3aTuGeaZm8Jg2I9K7ZC03iNlGz0EjxoGzg3+sdfjEWmyzHZnUWnlr9JY0azuEFPC
	 IeBXRFimqEVVCXhkNYsRR6LgWUD3aovkj8WueCcUXYbreXEwymg0bi7Gg9f93QjHvo
	 OoWJ+wc/FQSmkpx2RgWK9HjFQx93x9aPT0wXa9shXFMWFN/2spwkSB1/KcA3YPQEiJ
	 ascoG7Po4WP58rpgYHZP33f02lPeuQEhMLDE8hAeMHEzq3Fs90DOQOd2xF3Gm+fWMm
	 bfvh0k3leLQFQ==
Date: Fri, 6 Mar 2026 09:18:06 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Jingkai Tan <contact@jingk.ai>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>
Subject: Re: [PATCH v2] ACPI: processor: idle: Add missing bounds check in
 flatten_lpi_states()
Message-ID: <20260306-fine-golden-koel-dccbc1@sudeepholla>
References: <20260215002608.54934-1-contact@jingk.ai>
 <20260305213831.53985-1-contact@jingk.ai>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305213831.53985-1-contact@jingk.ai>
X-Rspamd-Queue-Id: 81F9321DC98
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21478-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MSBL_EBL_FAIL(0.00)[sudeep.holla@kernel.org:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@kernel.org,linux-acpi@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 09:38:31PM +0000, Jingkai Tan wrote:
> The inner loop in flatten_lpi_states() that combines composite LPI
> states can increment flat_state_cnt multiple times within the loop.
> 
> The condition that guards this (checks bounds against ACPI_PROCESSOR
> _MAX_POWER) occurs at the top of the outer loop. flat_state_cnt might
> exceed ACPI_PROCESSOR_MAX_POWER if it is incremented multiple times
> within the inner loop between outer loop iterations.
> 
> Add a bounds check after the increment inside the inner loop so that
> it breaks out when flat_state_cnt reaches ACPI_PROCESSOR_MAX_POWER.
> The existing check in the outer loop will then handle the warning.
> 

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep

