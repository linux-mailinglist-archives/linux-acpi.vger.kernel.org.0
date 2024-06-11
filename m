Return-Path: <linux-acpi+bounces-6296-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66755903361
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2024 09:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DBFA1F287B7
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2024 07:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293DF171094;
	Tue, 11 Jun 2024 07:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="aL2PHbKn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DD213D8BA;
	Tue, 11 Jun 2024 07:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718090609; cv=none; b=afglEajJH0dE2dhl3HNHp7D2hzUcP0phqQDpKclXLPFF/N5phZ43uuqNINFDZwqOSdlpGQdd7DaOk+J2j10aM1yGl3IFnDidgm1SNSE1dOxO+c8MuX/Ka4PKewfNsLaHL9d8bAKgxrpn6+noHaK2ZgcSPBICSiWALja4AUBhAgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718090609; c=relaxed/simple;
	bh=ntah1B6TNxTJU6A4v28dK0lBP6UT+q22EAg5yS8o46c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgpqmfOh8nGsC09yFVlmPri0NtArT483I+RCGjAmT9tcA6o7Rb05AH1ThBZs3b+uzgGeCNqlyVF0btkzs72Ajxyf8zohKs88H18J9XFoKvypIlqzVOc01LzjPvAPhc+2ht9q7UrvGptmCYfBm5dTgBMaVCKg3wWbZPf3oMtyGNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=aL2PHbKn; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718090604;
	bh=ntah1B6TNxTJU6A4v28dK0lBP6UT+q22EAg5yS8o46c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aL2PHbKn4z5F9p3lXLb5SBL8jedc9Ya/aH1cJVSlzgPTlOIUecQHo19ILfhiWmYZN
	 QU97PQpJSMhxhqhwersMTprkjtSyxR3wLLToZNBqopZUGdkJAuTarm3hwZOo2u+2gS
	 HAG+ZpbE5NDiJAacQXnEWmQcWagCjuFidmePbXHg=
Date: Tue, 11 Jun 2024 09:23:24 +0200
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
Message-ID: <f2a361aa-a256-41a5-8100-703e40df975d@t-8ch.de>
References: <20240610-cros_ec-charge-control-v3-0-135e37252094@weissschuh.net>
 <20240610-cros_ec-charge-control-v3-3-135e37252094@weissschuh.net>
 <ZmfvhvcjTbjOSp4f@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmfvhvcjTbjOSp4f@google.com>

On 2024-06-11 06:32:38+0000, Tzung-Bi Shih wrote:
> On Mon, Jun 10, 2024 at 05:51:08PM +0200, Thomas Weißschuh wrote:
> > If the command is not supported at all the EC returns
> > -EINVAL/EC_RES_INVALID_PARAMS.
> > 
> > This error is translated into an empty version mask as that is easier to
> > handle for callers and they don't need to know about the error details.
> 
> I'm not sure whether the behavior is what we want or not as existing
> EC_CMD_GET_CMD_VERSIONS usages don't have it.

At least the caller of cros_ec_get_host_command_version_mask() expects
it:

ret = cros_ec_get_host_command_version_mask(..., &ver_mask);
if (ret < 0 || ver_mask == 0)
...

ver_mask == 0 will never happen as in that case -EINVAL would have been
returned.

Others, like cros_ec_cec_get_write_cmd_version(), expect the current
semantic of ver_mask != 0 but log spurious errors in case of -EINVAL.
cros_pchg_cmd_ver_check(), works with both semantics, but currently also
logs a spurious error message.

To me the new semantic looks more obvious and much easier to handle.
For each command version a bit is set. no command versions -> no bits.

