Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009AA3CB39D
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jul 2021 09:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236894AbhGPH5i (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Jul 2021 03:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236682AbhGPH5i (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jul 2021 03:57:38 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FC3C06175F
        for <linux-acpi@vger.kernel.org>; Fri, 16 Jul 2021 00:54:42 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m2so11035139wrq.2
        for <linux-acpi@vger.kernel.org>; Fri, 16 Jul 2021 00:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RXAnbCrKzXxdulWuWjhiBHqvi57wTj4Ohxo+kKl9HOw=;
        b=mQwNRk/1js8bvvQAYSh0N7lvxkZBkN0e6L4NyrLFNRRTdKHXjbcs5BQT1LucqAlQ6j
         gAL5KxKHWwFVKF/5WSNtNR2oWbx/RSugbycGbPz/19kRUwCRxmd/b0PSefX0EI4Uwtew
         VRoYJ6qdAjIOQ3ToynlUMh91BiAD8jiEptoMLkhMa6OS+kL3NSkX6iovTsDbms+iFfYO
         wRugchhtSB8EEkStSapVdsjmFOSDg1RI/ng/pTPEPY2kxas4ueji269t162R4k3zWQGK
         TPXubHsJfNy7wpPsrTyNAf9Px2QbA7bVFkl5p8qo6sifqeZecwHuJr7hYwGUR5V27H4A
         A4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RXAnbCrKzXxdulWuWjhiBHqvi57wTj4Ohxo+kKl9HOw=;
        b=tgNsIZk10s0QExCMv0ecW7q4OHxiuEvxgtrpnI7Iva4LYeTize7xZWfjkO0AGsyt7Z
         ChnDvroyQ4AqmDerjXYc3p12cprkECgSv0ugpKSn1vIwJcX7G9KZgc3RcxP4pcNOuiVc
         vT1hhQmeCZZVtcVG/WBd7DQqORhBCHH/qJMnagcBB3pgrqNMwGtF6j3m3MnqawGIafYr
         RuV+K9I7eaWHf7F9t6zTymyiAHSxl/ImckXLnCpOdg8tnVj4Z1VLJZilhX68+n55Rnf/
         OTnDAxSKxa9I/iH3CnT31rjykAkKNZMva2CjmDrN5t4G6+DoCUAgNGUR8GPTBzjzV+v2
         JCJw==
X-Gm-Message-State: AOAM533kZGgj6DQhEzHdbpZzP4oIBp5sFCv3txMq0R/ry9NpwhCVefSc
        qLVjm+dN4xrqWXAYTqb2ksTyng==
X-Google-Smtp-Source: ABdhPJyjX5GGXwwNKwKJQhi0YSNyjTH1lPbfyB9nQiGS9M3eqXFaWAylyGEZCSR68Pjc+GikVIy9Vg==
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr10050960wrm.145.1626422081303;
        Fri, 16 Jul 2021 00:54:41 -0700 (PDT)
Received: from google.com ([31.124.24.141])
        by smtp.gmail.com with ESMTPSA id l18sm11472838wme.29.2021.07.16.00.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 00:54:40 -0700 (PDT)
Date:   Fri, 16 Jul 2021 08:54:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Clamshell <clamfly@163.com>
Subject: Re: [PATCH v2] mfd: axp20x: Update AXP288 volatile ranges
Message-ID: <YPE7Py9dZqagg9o1@google.com>
References: <20210629171239.6618-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210629171239.6618-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 29 Jun 2021, Hans de Goede wrote:

> On Cherry Trail devices with an AXP288 PMIC the external SD-card slot
> used the AXP's DLDO2 as card-voltage and either DLDO3 or GPIO1LDO
> (GPIO1 pin in low noise LDO mode) as signal-voltage.
> 
> These regulators are turned on/off and in case of the signal-voltage
> also have their output-voltage changed by the _PS0 and _PS3 power-
> management ACPI methods on the MMC-controllers ACPI fwnode as well as
> by the _DSM ACPI method for changing the signal voltage.
> 
> The AML code implementing these methods is directly accessing the
> PMIC through ACPI I2C OpRegion accesses, instead of using the special
> PMIC OpRegion handled by drivers/acpi/pmic/intel_pmic_xpower.c .
> 
> This means that the contents of the involved PMIC registers can change
> without the change being made through the regmap interface, so regmap
> should not cache the contents of these registers.
> 
> Mark the regulator power on/off, the regulator voltage control and the
> GPIO1 control registers as volatile, to avoid regmap caching them.
> 
> Specifically this fixes an issue on some models where the i915 driver
> toggles another LDO using the same on/off register on/off through
> MIPI sequences (through intel_soc_pmic_exec_mipi_pmic_seq_element())
> which then writes back a cached on/off register-value where the
> card-voltage is off causing the external sdcard slot to stop working
> when the screen goes blank, or comes back on again.
> 
> The regulator register-range now marked volatile also includes the
> buck regulator control registers. This is done on purpose these are
> normally not touched by the AML code, but they are updated directly
> by the SoC's PUNIT which means that they may also change without going
> through regmap.
> 
> Note the AXP288 PMIC is only used on Bay- and Cherry-Trail platforms,
> so even though this is an ACPI specific problem there is no need to
> make the new volatile ranges conditional since these platforms always
> use ACPI.
> 
> Fixes: dc91c3b6fe66 ("mfd: axp20x: Mark AXP20X_VBUS_IPSOUT_MGMT as volatile")
> Fixes: cd53216625a0 ("mfd: axp20x: Fix axp288 volatile ranges")
> Reported-and-tested-by: Clamshell <clamfly@163.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>


Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
