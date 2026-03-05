Return-Path: <linux-acpi+bounces-21429-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJ/0OfGpqWlSBwEAu9opvQ
	(envelope-from <linux-acpi+bounces-21429-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 17:06:09 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F3A2151AF
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 17:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CAAAC306BCD9
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 15:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0438C3CA4B3;
	Thu,  5 Mar 2026 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fttLAMQW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43D83C6A5A;
	Thu,  5 Mar 2026 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772725813; cv=none; b=mm+8PjCYUT+gzlNnBvDEWTVSx/XQCm7iCN2AusMww7hcUVnaRHgyvN9yI6moJry/zo3bCQOn4RSzbiq+Rw3I0f6g+Y3iNUt4aawm9WE98CF6JpqCKQRc0Ak+M5mVLFPT5I8F+CSbeP9JspBz8CMMhIs1sUmXbk679utXAQKNokQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772725813; c=relaxed/simple;
	bh=18Ib7x9aoQSlr32NwKxnTk094i+GFNOsW/pUeH5Wtr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmYF3Wrf3kgdymBBmrstmnLoL+1O4nmSdKE36Z8K32q2NDcwEm8oFPlTyksk3yCzSJ33kSZoOUFZ7bKKDZmQgeGi3gY4M8tUMcxV/vq7iP4bK6mBjZDYYW5uHaA+DMOeySkQSDV/JqMOlZ4FuvG/aN2lT9tcTpcD55EwQHrVkX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fttLAMQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A384C116C6;
	Thu,  5 Mar 2026 15:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772725813;
	bh=18Ib7x9aoQSlr32NwKxnTk094i+GFNOsW/pUeH5Wtr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fttLAMQWeylB1CbO/j2ryAj/fBaHySP40tengPn01l6oVFzBacQZ8SmpVFl1iU3Ul
	 0O9HzB6OwKN12E45f0vE55SVSr9f7CdQg/qCmGYMzZrbumUx/QhtPNTB6c1zPok+l4
	 xfhdyxhD41ufOyJd2V2sgIfjH3YYpdEKvtjahVLeFO6cETOhrL1vWpHR7OeOMolXIF
	 +72U8Hdox04A41cvGbL2LnVYmyUDJXhhgsksDX/8tPhz6fuDp9Pq39wBYuMDEFHJZ4
	 nzt3xeainVMK9xem9xpmopQErRTGF6nWi/ozUCtefmsJOKHVDpeXCgMqzNVQS9ZmbP
	 2fFOTtsUfPz9g==
Date: Thu, 5 Mar 2026 23:50:09 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: chrome-platform@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Enric Balletbo i Serra <eballetbo@kernel.org>,
	Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: Re: [PATCH v1 4/6] platform/chrome: chromeos_tbmc: Convert to a
 platform driver
Message-ID: <aammMeX3M83JZr6U@tzungbi-laptop>
References: <2274474.Mh6RI2rZIc@rafael.j.wysocki>
 <2553054.jE0xQCEvom@rafael.j.wysocki>
 <aamgGkgfFh-cQNfF@tzungbi-laptop>
 <CAJZ5v0jYk+RQu5RKUUh4caUE9vPQDgK1ss8B+=-HfPLZP6RsyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jYk+RQu5RKUUh4caUE9vPQDgK1ss8B+=-HfPLZP6RsyQ@mail.gmail.com>
X-Rspamd-Queue-Id: E1F3A2151AF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21429-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzungbi@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 04:34:26PM +0100, Rafael J. Wysocki wrote:
> On Thu, Mar 5, 2026 at 4:29 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > On Wed, Mar 04, 2026 at 07:44:26PM +0100, Rafael J. Wysocki wrote:
> > >  static void chromeos_tbmc_notify(acpi_handle handle, u32 event, void *data)
> > >  {
> > > -     struct acpi_device *adev = data;
> > > +     struct device *dev = data;
> > > +     struct acpi_device *adev = ACPI_COMPANION(dev);
> > >
> > >       acpi_pm_wakeup_event(&adev->dev);
> >                              ^^^^^^^^^^
> > If I understand it correctly, I think this should also be changed to `dev`?
> 
> Yes, it should.
> 
> Essentially, this needs to be the same device for which
> device_init_wakeup() has been called.
> 
> Sorry for missing this.
> 
> Do I need to resend the series with this fixes or would it be
> sufficient to send a v2 of this particular patch?

Please resend the series as v2, addressing the fix and the minor fix in
patch [2/6].

