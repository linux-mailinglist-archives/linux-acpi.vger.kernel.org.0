Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE9572C3EE
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2019 12:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfE1KHd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 May 2019 06:07:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:48979 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfE1KHd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 May 2019 06:07:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 03:07:32 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 28 May 2019 03:07:28 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 28 May 2019 13:07:28 +0300
Date:   Tue, 28 May 2019 13:07:28 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v3 1/4] acpi/irq: implement helper to create hierachical
 domains
Message-ID: <20190528100728.GV2781@lahna.fi.intel.com>
References: <20190527112720.2266-1-ard.biesheuvel@linaro.org>
 <20190527112720.2266-2-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527112720.2266-2-ard.biesheuvel@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 27, 2019 at 01:27:17PM +0200, Ard Biesheuvel wrote:
> +
> +/**
> + * acpi_irq_create_hierarchy - Create a hierarchical IRQ domain with the default
> + *                             GSI domain as its parent.

Please document the arguments as well.

> + */
> +struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
> +					     unsigned int size,
> +					     struct fwnode_handle *fwnode,
> +					     const struct irq_domain_ops *ops,
> +					     void *host_data)

Otherwise looks good to me.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
