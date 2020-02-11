Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99A2915954A
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2020 17:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgBKQpx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Feb 2020 11:45:53 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44687 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbgBKQpw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Feb 2020 11:45:52 -0500
Received: by mail-pl1-f194.google.com with SMTP id d9so4464363plo.11;
        Tue, 11 Feb 2020 08:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kQU52vFD01wCRI6xcbdJ8W49tkxndRn+8JE6iZvqixo=;
        b=RZzy2EgIYyyFmn8CyN6uPFjtnqzwxexjvk1Be15Dt+Q5d3569840w0Texk4apN0Fw0
         e+7gkjORWurzV6atxEqEwtDiwakyxzo2Ec6U0Y2ooQdFLBBvFQiZ+d7Et8y1TwvzVKBk
         /MYbjsbED5jwaBncIPeWB1XI0YZ0sM2tw6OXQ1jjNzhL8lQ02GkX/Q+2d5zTFaA3CfFs
         5HUE0AOWOv2L8kW9jRaChUtcsBksBlWcJKwoLx2XIk+hr+iBirmBYZvisdoC5wcIYXBV
         2PsPNwCq9fF7XJmPKLcUHyQXz0Sw48xw3t0N9JqUhrEUhRKITtuiaoasoyFD36q1/MD9
         R2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kQU52vFD01wCRI6xcbdJ8W49tkxndRn+8JE6iZvqixo=;
        b=QlilP95CVc0+1eohfSY9s2FLqHc8eOYAW2rwgf68rtVWbPawDEtGWgqx5kPgmSlF+9
         kyDwmGXCzbiNdkvGCPZSbxnsLy0mkTm4HTYrn3QzbRZdOLW7Xqw5EQF5Rz4OpUThBzNV
         uuIlRxCfL2PInv0FqRIZyZuLLh6SUo8HuxbGq9iOneyrru5G6IXUYCblnDOAAgeKp2HE
         LhuXx+Ke+ip+t+H3bq367QAhZszXXfTHrNP/GHzumvlkBXZk/AVIAHQcCQCY7Zz74xXh
         y/5UeJ6pNDXTKmqYILtrLy8AZhB9I6/hhGadcRRFocp/8FWiMrZxvgnIgUngLIONVnjY
         ncRQ==
X-Gm-Message-State: APjAAAUwqIT0vInsT/slpo4gKnxwAh+9y2xropmOCIMRLlc4TyBx1M46
        GSdM341FKknv3FfPQ8LijhFV/69o
X-Google-Smtp-Source: APXvYqwccCGZe/BO//cTrjYjd5vk1UEQ04YIEgtNYQOtIf0g7T0TlQ5Wo2gKOnbTyJnq98YtVjhbUQ==
X-Received: by 2002:a17:90a:cb8c:: with SMTP id a12mr4748571pju.71.1581439552221;
        Tue, 11 Feb 2020 08:45:52 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e11sm4508619pgj.70.2020.02.11.08.45.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Feb 2020 08:45:51 -0800 (PST)
Date:   Tue, 11 Feb 2020 08:45:50 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, Tom Abraham <tabraham@suse.com>
Subject: Re: wdat_wdt: access width inconsistency
Message-ID: <20200211164550.GB2975@roeck-us.net>
References: <20200210111638.64925c8e@endymion>
 <20200210112326.GP2667@lahna.fi.intel.com>
 <20200211141147.20bad275@endymion>
 <20200211135944.GF2667@lahna.fi.intel.com>
 <20200211172533.08b27181@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211172533.08b27181@endymion>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 11, 2020 at 05:25:33PM +0100, Jean Delvare wrote:
> On Tue, 11 Feb 2020 15:59:44 +0200, Mika Westerberg wrote:
> > If the default timeout is short then that might happen but I think WDAT
> > spec had some "reasonable" lower limit.
> 
> Could you please point me to the WDAT specification? Somehow my web
> search failed to spot it.
> 
> > You may set bigger default timeout during the probe by doing something
> > like below. This should give some 30s time before the system is rebooted
> > after the device is opened.
> > 
> > diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
> > index b069349b52f5..24351afe2718 100644
> > --- a/drivers/watchdog/wdat_wdt.c
> > +++ b/drivers/watchdog/wdat_wdt.c
> > @@ -439,6 +439,10 @@ static int wdat_wdt_probe(struct platform_device *pdev)
> >  	platform_set_drvdata(pdev, wdat);
> >  
> >  	watchdog_set_nowayout(&wdat->wdd, nowayout);
> > +
> > +	/* Increase default timeout */
> > +	wdat_wdt_set_timeout(&wdat->wdd, 30 * 1000);
> > +
> >  	return devm_watchdog_register_device(dev, &wdat->wdd);
> >  }
> 
> That is a very valid point. We know that the device works fine when
> using the iTCO_wdt driver, and the iTCO_wdt driver *does* set a timeout
> value at probe time, it does not rely on the BIOS having set a sane
> value beforehand. So maybe that's the problem.
> 
> Guenter, what is considered best practice for watchdog drivers in this
> respect? Trust the BIOS or set an arbitrary timeout value?
> 
Drivers should either set a valid timeout or read the timeout from
the chip. That does not mean that they always do that. Either case,
trusting the BIOS/ROMMON is not a good idea, because it may change.
When enabling the watchdog, the driver should make sure that the chip
timeout matches what it believes it should be, and that the watchdog
doesn't trigger immediately but only after that timeout period
expires. Not all drivers do that either.

> Maybe we should read the timeout value before enabling the device, and
> if it is unreasonably low (< 5 seconds), log a warning and reset the
> value to a sane default (30 seconds)?
> 
> Alternatively, or in addition to that, maybe the wdat_wdt driver should
> have a module parameter to set the default timeout value, as the
> iTCO_wdt driver has? Or is this deprecated in favor of the
> WDIOC_SETTIMEOUT ioctl? Problem with the ioctl is that it requires the
> device node to be opened, which starts the count down (I think?)
> 
No, the module parameter hasn't been deprecated.

Guenter
