Return-Path: <linux-acpi+bounces-970-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06497D734B
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DFEDB20ABD
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 18:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBE230F8D
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jqyc/pzO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AABA2E658
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 17:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE601C433C7;
	Wed, 25 Oct 2023 17:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698254559;
	bh=TpVWJFapHo0VMT3nduTVoXX71bNPxxczuV+vN2OQlj4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Jqyc/pzOjnUqQi1ENoMFIHd7NAJDIILKbOQvRshNeIA3ZnJKYJGIT5ZdBwEKw6eZr
	 PvaG2CsPwhJ6ndvZ6rX/02SEki/3nG+d0/O4kjEL/BlQ6bVlkGoSl826D76E0kq59K
	 /BxYttdXvaH/+fNXL7Elqx25hV8Hr7uMHo6BleqPNvpQthRCZENDhE7p2vpgfVBSo+
	 VeFXA9HJ1CsHXY5l8hClMG4s1bcShaSrmYRWHIBqYDSILDENJmbXn9URBdku28K1AR
	 The3ZP1ObSvDReM0tXcECgSlgcH0PeX0AFm7BONVLizklk0qQwaRQKsF/vr2F9voHy
	 Wd1lv6GQYGqjQ==
Date: Wed, 25 Oct 2023 12:22:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: D Scott Phillips <scott@os.amperecomputing.com>
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
	Darren Hart <darren@os.amperecomputing.com>,
	patches@amperecomputing.com
Subject: Re: [PATCH v2 2/2] PCI: hotplug: Add extension driver for Ampere
 Altra hotplug LED control
Message-ID: <20231025172237.GA1754650@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930002036.6491-2-scott@os.amperecomputing.com>

On Fri, Sep 29, 2023 at 05:20:36PM -0700, D Scott Phillips wrote:
> On Ampere Altra, PCIe hotplug is handled through ACPI. A side interface is
> also present to request system firmware control of attention LEDs. Add an
> ACPI PCI Hotplug companion driver to support attention LED control.
> ...

> +	arm_smccc_smc(REQUEST, LED_CMD, led_status(status), LED_ATTENTION,
> +		      pci_domain_nr(bus) | (PCI_SLOT(root_port->devfn) << 4), 0, 0,

pci_domain_nr() returns "int" (normally 32 bits), but since this is an
ACPI system, the domain comes from _SEG, which is defined to be 16
bits (ACPI r6.5, sec 6.5.6).

So it looks like ORing in the "slot << 4" clobbers the upper 12 bits
of _SEG.

Is this code doing the right thing?

