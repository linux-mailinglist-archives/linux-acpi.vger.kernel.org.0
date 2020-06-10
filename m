Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581421F5DBE
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jun 2020 23:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgFJVkj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Jun 2020 17:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFJVki (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Jun 2020 17:40:38 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B40EC03E96B;
        Wed, 10 Jun 2020 14:40:37 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b5so1680946pfp.9;
        Wed, 10 Jun 2020 14:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pDwBTDmz3h0k/Aa3ZIm7vgzuvxX5g50pVAUx5KvQiPQ=;
        b=h10aYUlEPNY5EN6tcEAW90D8lA7EaGATkGLiJubPsgJTNvC5lis0cvR/F3QVAxQ9Ou
         Ty5j3hRyob2dBjMhCz+z5NdVkUgk/58htoogS3cOplw2E9YHW4qfj3eF2C6DF0A45UOt
         T09HmnknJ/4E4xOM7dDkiFIXFzn7wACcet0+MyUYQnuHPwRR5/jUm/PKbLMZB/8mN/mH
         aqg02scvbRuZmctCdYTWskdEv0l/dwWlHfSO1wKl/cfMDh+XkWMzgbef7glM0j/gxvjD
         JPscCpWVjW7Djmf7ggGEHobvEON0yV8zwArP1tEwMMPobNg/afbPH+oHHgnM9MwukWRA
         5SpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pDwBTDmz3h0k/Aa3ZIm7vgzuvxX5g50pVAUx5KvQiPQ=;
        b=mnVTrXsCc4h6bYNOUtywSs78m5ss5RRJyQSSkDFOBcyCL6EaiGl4kRnNMeyOITdyPy
         wOCRlhIxohHm2GR7p/FmbZ7P1bgyJiHehWqLCwLn7LnM9HwhSdqfZ5JbkuT5Vie+pmAH
         PRzXdBJbTNH/qlY1hvKGFzm5iQZife2RUKUTDd1Zqhi1YBcG/duSrXcXvHMrcA4dNxCv
         0MTKxKBHhOL0/BqY9mNSv4m2uyxXD+24r7rnoUiBiOhoeA1NfXZ4WkouAf19RgtJCKJN
         ymp9Hg2ncUCNERl3b0OB1XkjCpLJFjur1gGImMBL0V1HZmyJXkKg941kalgidSVrChWS
         14zg==
X-Gm-Message-State: AOAM5321+eSdBqrd88FMyUuPrA1ieYahuDkVmAh8HUMAHH8G9BcYXHv7
        GjFlQ80VKfW9Edp6MqT/tJY=
X-Google-Smtp-Source: ABdhPJz4PlRdz3hoskZuX2GuS4FTJZ6XL1A64DLud2JvOjheTpNwcaEuuf6RtDF7SKfYOHhsnHdywQ==
X-Received: by 2002:a63:a363:: with SMTP id v35mr3913447pgn.95.1591825236795;
        Wed, 10 Jun 2020 14:40:36 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3c2a:73a9:c2cf:7f45])
        by smtp.gmail.com with ESMTPSA id x14sm838195pfq.80.2020.06.10.14.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 14:40:36 -0700 (PDT)
Date:   Wed, 10 Jun 2020 14:40:33 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mario.Limonciello@dell.com
Cc:     enric.balletbo@collabora.com, rjw@rjwysocki.net, rafael@kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        lenb@kernel.org, kernel@collabora.com, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org,
        vbendeb@chromium.org, andy@infradead.org, ayman.bagabas@gmail.com,
        benjamin.tissoires@redhat.com, blaz@mxxn.io, dvhart@infradead.org,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        jeremy@system76.com, 2pi@mok.nu, mchehab+samsung@kernel.org,
        rajatja@google.com, srinivas.pandruvada@linux.intel.com,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4] platform: x86: Add ACPI driver for ChromeOS
Message-ID: <20200610214033.GB248110@dtor-ws>
References: <20200413134611.478441-1-enric.balletbo@collabora.com>
 <CAJZ5v0gWZ27_DwWQadsJOUxLo4a0rAMe45d4AWXS2gHJZfgfKg@mail.gmail.com>
 <a2953d50-da22-279a-f1e4-faa796d815b1@collabora.com>
 <10490419.gsntqH5CaE@kreacher>
 <4e7f8bf3-b72b-d418-ec95-e1f8c3d61261@collabora.com>
 <59771d3689da41a5bbc67541aa6f4777@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59771d3689da41a5bbc67541aa6f4777@AUSX13MPC105.AMER.DELL.COM>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 10, 2020 at 09:28:36PM +0000, Mario.Limonciello@dell.com wrote:
> > 
> > To give you some references, if I'm not wrong, this prefix is used in all
> > or
> > almost all Intel Chromebook devices (auron, cyan, eve, fizz, hatch,
> > octopus,
> > poppy, strago ...) The ACPI source for this device can be found here [1],
> > and,
> > if not all, almost all Intel based Chromebooks are shipped with the
> > firmware
> > that supports this.
> 
> You can potentially carry a small patch in your downstream kernel for the
> legacy stuff until it reaches EOL.  At least for the new stuff you could
> enact a process that properly reserves unique numbers and changes the driver
> when the interface provided by the ACPI device has changed.

If we use this prefix for hatch EOL is ~7 years from now.

Thanks.

-- 
Dmitry
