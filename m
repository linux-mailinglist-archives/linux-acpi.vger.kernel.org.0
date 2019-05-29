Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A55DD2D65F
	for <lists+linux-acpi@lfdr.de>; Wed, 29 May 2019 09:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfE2Hbf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 May 2019 03:31:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:16628 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfE2Hbf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 29 May 2019 03:31:35 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 May 2019 00:31:34 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 29 May 2019 00:31:30 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 29 May 2019 10:31:29 +0300
Date:   Wed, 29 May 2019 10:31:29 +0300
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
Subject: Re: [PATCH v4 4/4] gpio: mb86s7x: enable ACPI support
Message-ID: <20190529073129.GP2781@lahna.fi.intel.com>
References: <20190528133647.3362-1-ard.biesheuvel@linaro.org>
 <20190528133647.3362-5-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528133647.3362-5-ard.biesheuvel@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 28, 2019 at 03:36:47PM +0200, Ard Biesheuvel wrote:
> Make the mb86s7x GPIO block discoverable via ACPI. In addition, add
> support for ACPI GPIO interrupts routed via platform interrupts, by
> wiring the two together via the to_irq() gpiochip callback.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Hmm, I thought I reviewed this already? Well anyway,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
