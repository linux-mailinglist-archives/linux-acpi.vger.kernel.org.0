Return-Path: <linux-acpi+bounces-276-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CBE7B2873
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 00:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 136971C20A2F
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 22:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA1B19458
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 22:31:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DE69CA71
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 21:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A41EC433C8;
	Thu, 28 Sep 2023 21:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695936389;
	bh=Pzrz7c74E/lphkzgfD3c3rCMhh8QlzjjCU95eb8xKS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kHAGcc6ex2bv7IRURZw5Y3AOqUaOHLsGe3rpAs8QVKL6eZeAH612si2WZ0iga5807
	 1pi08W2pepKJS6EraXELAaOK46cdFtTDXHk8HNMWS+RiG/9XBdmuV3uQynBGEz05My
	 rL/zzhyLE/8sneCjpFpVrTz/Ggkaf9TvUCpfMrqT6gM5SYnnfOazenchBZCdY+UOtA
	 lBmQg7jOonmtkPNlEsj2kOfCXaRxPEWSojQ/oMuPYIGY3YplKdIrANAdLrNCp81vyW
	 q2SE6n1BlahMayNOmlShXPV/AILxH6BDhQcxBQWRW78xo3iW5/ee7ANkrRhKmCAoYy
	 dkVsjlzvnaIIA==
Date: Thu, 28 Sep 2023 16:26:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: D Scott Phillips <scott@os.amperecomputing.com>
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org,
	Darren Hart <darren@os.amperecomputing.com>,
	patches@amperecomputing.com
Subject: Re: [PATCH] PCI: hotplug: Add extension driver for Ampere Altra
 hotplug LED control
Message-ID: <20230928212627.GA502803@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86y1gqj9kg.fsf@scott-ph-mail.amperecomputing.com>

On Thu, Sep 28, 2023 at 02:02:07PM -0700, D Scott Phillips wrote:
> Bjorn Helgaas <helgaas@kernel.org> writes:
> > On Wed, Sep 27, 2023 at 01:23:47PM -0700, D Scott Phillips wrote:
> >> On Ampere Altra, PCIe hotplug is handled through ACPI. A side interface is
> >> also present to request system firmware control of attention LEDs. Add an
> >> ACPI PCI Hotplug companion driver to support attention LED control.

> >> +config HOTPLUG_PCI_ACPI_AMPERE_ALTRA
> >> +	tristate "ACPI PCI Hotplug driver Ampere Altra extensions"
> >> +	depends on HOTPLUG_PCI_ACPI
> >> +	depends on HAVE_ARM_SMCCC_DISCOVERY
> >> +	depends on m
> >
> > Why is this restricted to being a module?  It's not unprecedented, but
> > unless this only works as a module for some reason, I would leave that
> > choice up to the user.
> 
> I did that because acpiphp_register_attention() wouldn't register the
> handler unless it was built as a module. Maybe better would be this
> change first:
> 
> --- a/drivers/pci/hotplug/acpiphp_core.c
> +++ b/drivers/pci/hotplug/acpiphp_core.c
> @@ -78,8 +78,7 @@ int acpiphp_register_attention(struct acpiphp_attention_info *info)
>  {
>  	int retval = -EINVAL;
>  
> -	if (info && info->owner && info->set_attn &&
> -			info->get_attn && !attention_info) {
> +	if (info && info->set_attn && info->get_attn && !attention_info) {
>  		retval = 0;
>  		attention_info = info;
>  	}

I would investigate the history of that "info->owner" check to see if
it's required somewhere.  If not, it seems like we could drop it.

At one time, we did support building hotplug drivers, including
acpiphp, as modules, but we no longer do.  Maybe that test dates from
that time.

Bjorn

