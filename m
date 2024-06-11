Return-Path: <linux-acpi+bounces-6301-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D33903BB1
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2024 14:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26621F21DAB
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2024 12:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7E617B510;
	Tue, 11 Jun 2024 12:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="InSLXQjJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF1117B437;
	Tue, 11 Jun 2024 12:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718108079; cv=none; b=jFM3rDC9vFu1p070UwqU3JpUu2KUiQg8da7cFOEmT0IqwmNZ+MnquBiBaZarxZ1PwW69OjfCeywv+xE1FlymHnPKhTNNY62j5F4SoMmt66EC3apdrdP8eE4OrZ8FVX+8rtz/CYlPtbF9CgIRb/dFiTMpm1Mw97Er20q19MTliYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718108079; c=relaxed/simple;
	bh=w7B40PWl4Af4+RQcs+mNnifx0/byH1T0JsOks/U3U5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tarruPt7DVZNlJ8Nkwe+dq6XQ1xlITZfcC1JoYQTAzWyVIKClog9tCxIe0lMhjNOcgue8HcN+4e+Fb6yvbq8PvP5smWHS6bG12VyhBYSn5JsCe2QY4ek0fQZI5xraZWW9RXciC6chUvBZS42vFXPpJJUlBHcGARTaFDjyNqeh2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=InSLXQjJ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718108074;
	bh=w7B40PWl4Af4+RQcs+mNnifx0/byH1T0JsOks/U3U5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=InSLXQjJdt0FPAI3RfJ1IGJQTgNkD4rsynDmJ4EGpEKjJa3UQ6I5YvisnYhh1mSoF
	 neKB6U27SbKBAInaB5VIEjmXsDxSr2Ycz8jK/nx9wz6+1P8TiWJnczqi1i7OIoJu6R
	 t27zeQRRJ8Zdby3Dl8Mk2CA42TVjY6m/4Alts8BM=
Date: Tue, 11 Jun 2024 14:14:33 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Sebastian Reichel <sre@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
	Dustin Howett <dustin@howett.net>, Stephen Horvath <s.horvath@outlook.com.au>, 
	Rajas Paranjpe <paranjperajas@gmail.com>, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	Matt Hartley <matt.hartley@gmail.com>
Subject: Re: [PATCH v3 3/5] platform/chrome: cros_ec_proto: Introduce
 cros_ec_cmd_versions()
Message-ID: <96f0d632-7fdd-4fca-9528-449440d72f5d@t-8ch.de>
References: <20240610-cros_ec-charge-control-v3-0-135e37252094@weissschuh.net>
 <20240610-cros_ec-charge-control-v3-3-135e37252094@weissschuh.net>
 <Zmg2iwOWRZdCybxw@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zmg2iwOWRZdCybxw@google.com>

On 2024-06-11 11:35:39+0000, Tzung-Bi Shih wrote:
> On Mon, Jun 10, 2024 at 05:51:08PM +0200, Thomas Weißschuh wrote:
> > +/**
> > + * cros_ec_cmd_versions - Get supported version mask.
> 
> I guess we would like to call it something like "cros_ec_get_cmd_versions".

Ack.

> > + *
> > + * @ec_dev: EC device
> > + * @cmd: Command to test
> > + *
> > + * Return: version mask on success, negative error number on failure.
> > + */
> > +int cros_ec_cmd_versions(struct cros_ec_device *ec_dev, u16 cmd)
> 
> Could it support a "version" parameter as existing EC_CMD_GET_CMD_VERSIONS
> usages use both versions?  An `u16 cmd` parameter and down-cast to u8 for v0
> should be fine. (ec_params_get_cmd_versions vs. ec_params_get_cmd_versions_v1)

Ack.

Or we could automatically use v0 if cmd <= U8_MAX?

