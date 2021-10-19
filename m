Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997024335BA
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Oct 2021 14:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhJSMTa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Oct 2021 08:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhJSMTa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Oct 2021 08:19:30 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ECBC06161C;
        Tue, 19 Oct 2021 05:17:17 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id v8so13312694pfu.11;
        Tue, 19 Oct 2021 05:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=HWaF+++REMznNvpJiE6JG2z8SLyWqKnYc7C9QzfgitA=;
        b=Djrut6kKLnuDAX1lZnwlnek5v/1LasGcBrOg6WDKpN75Rmd41NOCouRy94LwuVBh91
         1epl/P2UUaIaeAEFmxJMTovIEZpmXNxmibkEAKeW3EDNPgFORlJvFJ4qVHBExR0RbdUA
         mwmPasS2Fn1iS66+AqHmu+PpjcAnTQV8cdMkctbdvHhBE00wOPpWW7LdZIBPORGTwBVC
         dq15K67UAdctijr1mJdtF5cLK+SURZO2Vpq46/+tEgseNzEhm57zBZIozj4lSehhUqUX
         DK0gtv2LwZ7l77SMPhaQRelGcHtHtsC97xUUHoi1gmNNiBwmQ30ORwCuQg4f7vILUx6/
         gCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=HWaF+++REMznNvpJiE6JG2z8SLyWqKnYc7C9QzfgitA=;
        b=iNbhSNS3QcXH2NBa++1/d9hgljJeRSDNejwBKYMFeBrCEPy5KOMr40coRuWMxkLIh5
         u1qM/3gHkjBAe/KjNVYIvvAgtA4y6hUKXnBmPBYlybUi5+flZQybhrJDV/nVdUeOW2JD
         SiNNzBBH2aTCRx9fNhy6pm1W1j6+9ayt5gsO01R9UIKp5w5/4F1brrGa/f29nfAUgFN7
         i80zquFjm36XZCnEaaO9DAy9PHWrml9uQniwlbJtrV0hGIrmvoG3dSic3lg52KMTX36S
         pLmFGwCfUMBGDxCX4mrtlXlLRyNA0r4M1xd39MnChCspfxgA5JlNCZKEVJCPzrPKgn2j
         2Y+Q==
X-Gm-Message-State: AOAM532kxOUfKDoU7Ztchp2GfOYfwIO7tbHxAOfusCpkWdq/xK3beEzd
        l0QwMKOZHO3//GfGJsMECSs=
X-Google-Smtp-Source: ABdhPJxTqy6MfCMeLDN0EfE00NawwhTEKXEMO8BKoC+O+L8UW1mNBbE/YXc384xdYAiMlzJ9sdMYnQ==
X-Received: by 2002:aa7:983a:0:b0:44d:8bc8:b0ac with SMTP id q26-20020aa7983a000000b0044d8bc8b0acmr29936275pfl.83.1634645837233;
        Tue, 19 Oct 2021 05:17:17 -0700 (PDT)
Received: from ?IPv6:2400:4052:6980:3800:dba7:2b1f:3f26:a5ec? ([2400:4052:6980:3800:dba7:2b1f:3f26:a5ec])
        by smtp.gmail.com with ESMTPSA id i11sm5798618pgp.18.2021.10.19.05.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 05:17:16 -0700 (PDT)
Message-ID: <bba35342b4a0fcb2a707c10662e57e4d0e668770.camel@gmail.com>
Subject: Re: [RFC PATCH 1/1] ACPI / PMIC: Add i2c address to
 intel_pmic_bytcrc driver
From:   Tsuchiya Yuto <kitakar@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Oct 2021 21:17:13 +0900
In-Reply-To: <YW60cwMHNoTYgQL6@smile.fi.intel.com>
References: <20211017161523.43801-1-kitakar@gmail.com>
         <20211017161523.43801-2-kitakar@gmail.com>
         <3e6428f1-9411-fac6-9172-1dfe6de58c28@redhat.com>
         <23d641620aebd1aa47fd73d040dec4ad8974d03d.camel@gmail.com>
         <YW60cwMHNoTYgQL6@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 2021-10-19 at 15:05 +0300, Andy Shevchenko wrote:
> On Tue, Oct 19, 2021 at 08:56:04PM +0900, Tsuchiya Yuto wrote:
> > On Mon, 2021-10-18 at 11:16 +0200, Hans de Goede wrote:
> > > On 10/17/21 18:15, Tsuchiya Yuto wrote:
> 
> ...
> 
> > > Tsuchiya, can you give the attached patch a try.
> > 
> > Thanks!
> > 
> > I tried your attached patch, and I can confirm that it's working as
> > expected.
> > 
> > Now it's using cht one:
> > 
> >         $ ls /sys/devices/pci0000:00/808622C1:05/i2c-5/i2c-INT33FD:00
> >         cht_crystal_cove_pmic  crystal_cove_gpio  crystal_cove_pwm  driver  firmware_node  modalias  name  power  subsystem  uevent
> > 
> > and the function intel_soc_pmic_exec_mipi_pmic_seq_element() is also
> > working with atomisp driver.
> 
> To be formal you may give a dedicated tag here, i.e. Tested-by:.
> It will be easier for tools, such as `b4`, to catch it up
> and not forget.

Thanks!

Hm, then, not sure if mine is helpful but here is
Tested-by: Tsuchiya Yuto <kitakar@gmail.com>

Regards,
Tsuchiya Yuto

