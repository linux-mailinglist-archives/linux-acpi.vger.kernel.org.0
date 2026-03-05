Return-Path: <linux-acpi+bounces-21423-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPmhKc6hqWl5BQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21423-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 16:31:26 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4748421492B
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 16:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A90830358AB
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 15:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66AC39C63E;
	Thu,  5 Mar 2026 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3C+WYLD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35B3190462;
	Thu,  5 Mar 2026 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772724582; cv=none; b=A23y+zohjYvwTrPUIyycMpgtWN2cETnKQ7Znnnkm+AfqhxI0l+Z/v+pmLuY8igaXJZeAFxNlCHdpJaKMuY0pHhIV73S+HMMFSViCbynqIvFgOAU2Cx5ZOyDZo95P+6wFdcq5NkZwfoxoEVPIJLBH0uajwSY3IVbN1erWXfRvhgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772724582; c=relaxed/simple;
	bh=l66jhLVas2Ia2awwsrvJbzUpshjuGV3BhaadeglMitE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHN1WsugOj36x1mlcNWK4zff9t0w5hWJTHH3FG8R34P/7aXn7V2gUSeBKp1zgVTs6ZJCD42Gi7oxtw/Y3P2DYvwPbfzl1C1HwTuuaUfat3c0d3U4WisHJOohw4G7dmdFj1J0KT1A9hbMXIHZA/g8DFmrdhUZ0/jLHOeQIeCjNYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3C+WYLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50600C116C6;
	Thu,  5 Mar 2026 15:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772724582;
	bh=l66jhLVas2Ia2awwsrvJbzUpshjuGV3BhaadeglMitE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G3C+WYLD2+TXiDLmNWENrPfCpAs87hi9rMNOJSI8+ruJyRvDR30BFYjn5MOe/iAT1
	 DwHbvb5dq/kVM+a0WCmVYYzD3lofyBem3Pc+O33foHoRDCw2dVunNcUn8SwHN/GRvG
	 sMTG9MhfYFz6zHekkNsDzlqx8DjHFd1CgVnb7nw9YrI0bYjgbk9NECERsryLMdrnIN
	 LxdA+4H3+WTOjTdL9VgvStkfSA1q/EkJHokGTonisDbcsMy44f8qyMJOX/AQ+qHLbk
	 LoEzfveJooU0zUdeL9vIhyqrXU/9d2zZM6qcYvUxgqUi+uMRfu1UrKEfptOAzJjfsm
	 j/r/61HZQbNaQ==
Date: Thu, 5 Mar 2026 23:29:37 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: chrome-platform@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Enric Balletbo i Serra <eballetbo@kernel.org>,
	Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: Re: [PATCH v1 4/6] platform/chrome: chromeos_tbmc: Convert to a
 platform driver
Message-ID: <aamgGkgfFh-cQNfF@tzungbi-laptop>
References: <2274474.Mh6RI2rZIc@rafael.j.wysocki>
 <2553054.jE0xQCEvom@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2553054.jE0xQCEvom@rafael.j.wysocki>
X-Rspamd-Queue-Id: 4748421492B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21423-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzungbi@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 07:44:26PM +0100, Rafael J. Wysocki wrote:
>  static void chromeos_tbmc_notify(acpi_handle handle, u32 event, void *data)
>  {
> -	struct acpi_device *adev = data;
> +	struct device *dev = data;
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
>  
>  	acpi_pm_wakeup_event(&adev->dev);
                             ^^^^^^^^^^
If I understand it correctly, I think this should also be changed to `dev`?

