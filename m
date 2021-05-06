Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4942374D3A
	for <lists+linux-acpi@lfdr.de>; Thu,  6 May 2021 04:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhEFCCR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 May 2021 22:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhEFCCP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 May 2021 22:02:15 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2E5C061761
        for <linux-acpi@vger.kernel.org>; Wed,  5 May 2021 19:01:17 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id s25so5060119lji.0
        for <linux-acpi@vger.kernel.org>; Wed, 05 May 2021 19:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bdTXCNCJehL6L2FUf8dVXHKc7By/gl2K5wPWDUG3aHQ=;
        b=npobrFmjY3F/BH+4xzy01aYi8zEKzmvijsn8BvArbMYGIHjuVw12soYgAUuljvq437
         ijinaGUa2nwrdIX6K0US0d8kCc8WaqMpFWp/SvGxO0J9t7zlL5aglEGTqJFF8zYq7+4C
         JcPrxUw08b+nKEgEIV9SF0F5gBROZjIfYFmAqw3mpa0TEFSXrlgDhwoyRp/EXQE3bNZZ
         IQlOv8v0JRXs3HODzvEykjvqSaxKbh/qsQs08y/s3Z28PjfG7bMZ3xvVcaAWfPgSCdOH
         uGLi1Zc/gWf4hzXTB4v1LHXTDoZnvXVU+7i/OPaG+ZfwRuuhqyvB6e90+GZCD33QU+50
         IMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bdTXCNCJehL6L2FUf8dVXHKc7By/gl2K5wPWDUG3aHQ=;
        b=JhdyGBzO7dSeT3GVlb35mUR68wvJeBemhwPE7rGUSqg06QMhjE/HbdF9a2o1IxBEMS
         wTB42gs5pzcIOITzdHcbQavd+xhUFhQOp4DyY+CmP52VsGDLWAciXElvSFwVQx2cJ/Go
         zRmuWLfuxkHzMORQV/ifpuRLZfTW6wdjBFcsuXrK0zRVyzsc8wNpDHJj011+SgnYuHPh
         10YCNeWdBBtMaiPBu1UPfatNMuKQoazdZ48DeeZjegl9WM5OqeGN9Xx918jCh4QmwiH0
         vc+0rsyPCme+P3AowAC7xOgr/uH191gWaFBsjId/4KAGTTbjE747O7dbD16ct5QuFrtK
         iHgA==
X-Gm-Message-State: AOAM533M7EbSy+x5lJOuvGEJV1XiCt8+Nc5hG1l7bnblXotDEQuuCK8A
        vAWfbr/2hv814Ipp0htXsW6bQXQMDkVGVBpx+7CmBA==
X-Google-Smtp-Source: ABdhPJzuud5nGxGBZKvJcULbXiIs/DImEdzGgjgMpVJb4t+vKkxZ5/hCS6RKqUESMVNkt//sfbFh2OWHgfIJ5t7gADI=
X-Received: by 2002:a2e:b4c3:: with SMTP id r3mr1283898ljm.232.1620266475764;
 Wed, 05 May 2021 19:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210506004423.345199-1-saravanak@google.com>
In-Reply-To: <20210506004423.345199-1-saravanak@google.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 5 May 2021 19:01:04 -0700
Message-ID: <CALAqxLU+Uf6OSDLG8OC_gHY9-VVHPgu0_bXxJcO8B4peFugtqw@mail.gmail.com>
Subject: Re: [PATCH v1] usb: typec: tcpm: Don't block probing of consumers of
 "connector" nodes
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 5, 2021 at 5:44 PM Saravana Kannan <saravanak@google.com> wrote:
>
> fw_devlink expects DT device nodes with "compatible" property to have
> struct devices created for them. Since the connector node might not be
> populated as a device, mark it as such so that fw_devlink knows not to
> wait on this fwnode being populated as a struct device.
>
> Without this patch, USB functionality can be broken on some boards.
>
> Fixes: f7514a663016 ("of: property: fw_devlink: Add support for remote-endpoint")
> Reported-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Tested-by: John Stultz <john.stultz@linaro.org>

Thanks so much for this fix! HiKey960 is back to booting properly!
-john
