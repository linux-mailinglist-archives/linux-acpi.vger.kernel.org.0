Return-Path: <linux-acpi+bounces-6299-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AED903A6E
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2024 13:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4DA1F24632
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2024 11:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A247717BB3F;
	Tue, 11 Jun 2024 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGeAbiLO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF8717B4E5;
	Tue, 11 Jun 2024 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718105744; cv=none; b=cjg+TJpVOEUiYNK2VLgS7Mb0Zpr1qwwJriKGTAJdDERXwVfxwXmGamFmCNGX26uc7kTJnvrlEDyvaarMSjshjR0KPpKfnD76LlRNwMYkTi5JIpBFw3YfTOzsr5BBjJ59xOtn3ufZFp3RQrLDvUnx4uiVa3Jto2EqkTg9GDPkpxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718105744; c=relaxed/simple;
	bh=vIaLVeSYJywYPlUcMLIYwb/jAbrcLibb815/nDIAGBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLeH7/Nq8LWZqsefIL5As4tLCMqXK8NILm93hrwlej/Lov8QRbQ4Jy3iGnzcHjfFPAl1gNtcUWdsbAIgT5bsOKVuPY76UIwWtVs+PJQnxD5nKNtqLnrngjOblbdMhdFuMlsgYgbMrx3GRwOjKv2HbuvGHMbR+gpvMhSG6b2VJNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGeAbiLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F19C2BD10;
	Tue, 11 Jun 2024 11:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718105744;
	bh=vIaLVeSYJywYPlUcMLIYwb/jAbrcLibb815/nDIAGBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eGeAbiLOO3DqDwHlEs/APyA1y1dEWYbCwpzafcNR/tGNz0bvVdTtqhVi8kncr81HZ
	 8fljverjE72HAzzi4aT9b0MUf5vh3gRejleNYPLm7LcjrpWV0PgWYxmtWScT8Z34dH
	 wMmo+HziDKICuEUmC/GXseLNJ3IwLldp+iiwKM6WkND+++R45Lob56f/8IrwsJCFMT
	 Jp1iWn2909ijRn81+K9hpvAOkGYwejKopGBHAND/lOT0kAci83ubIGgSyEl9gf8XiJ
	 Tex3N45V4jv8d0EJnnsFMKkQNefyYEBpPsXJRk0XmREr/QxSTeoQQ823C17TPHU4gG
	 P7yucmuEf+gTg==
Date: Tue, 11 Jun 2024 11:35:39 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	Sebastian Reichel <sre@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@weissschuh.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Dustin Howett <dustin@howett.net>,
	Stephen Horvath <s.horvath@outlook.com.au>,
	Rajas Paranjpe <paranjperajas@gmail.com>,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	Matt Hartley <matt.hartley@gmail.com>
Subject: Re: [PATCH v3 3/5] platform/chrome: cros_ec_proto: Introduce
 cros_ec_cmd_versions()
Message-ID: <Zmg2iwOWRZdCybxw@google.com>
References: <20240610-cros_ec-charge-control-v3-0-135e37252094@weissschuh.net>
 <20240610-cros_ec-charge-control-v3-3-135e37252094@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610-cros_ec-charge-control-v3-3-135e37252094@weissschuh.net>

On Mon, Jun 10, 2024 at 05:51:08PM +0200, Thomas Weißschuh wrote:
> +/**
> + * cros_ec_cmd_versions - Get supported version mask.

I guess we would like to call it something like "cros_ec_get_cmd_versions".

> + *
> + * @ec_dev: EC device
> + * @cmd: Command to test
> + *
> + * Return: version mask on success, negative error number on failure.
> + */
> +int cros_ec_cmd_versions(struct cros_ec_device *ec_dev, u16 cmd)

Could it support a "version" parameter as existing EC_CMD_GET_CMD_VERSIONS
usages use both versions?  An `u16 cmd` parameter and down-cast to u8 for v0
should be fine. (ec_params_get_cmd_versions vs. ec_params_get_cmd_versions_v1)

