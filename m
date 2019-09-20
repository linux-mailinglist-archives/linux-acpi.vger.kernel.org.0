Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B00B1B9898
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Sep 2019 22:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbfITUnr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Sep 2019 16:43:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54177 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730071AbfITUnr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Sep 2019 16:43:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id i16so3844357wmd.3;
        Fri, 20 Sep 2019 13:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lJRjCM+MHGrkfk6BQUd45RS2LvGotJKtsd5H7I/2Cv4=;
        b=V5B9TQ5qdvMobLTSBJrbyM69mHlXh+3cZeHCR9zPBSa1zvhkycKe8w0McIhcu+rlCN
         om8/34+D8gYk03IAjsQEpT2MyGnSIqyMoGlLI+noYkeQDERgqqGQFAnHJyM7l+Hy1Ca+
         QIGAeT9TuoPXezzOXpYovjL6YT5XOEq+AHT++6W1g8H7JaA/I6j2l/BirEjF31QIrVeA
         Hgdij+Dg2FKBh2qJEkHNrOsyHhYNV0ofDL55KScvLePBvguOLwrg8YrJksmVrEnKr2fm
         i+hQ0z0gXwWcR6Sbey1m33ycVV7cfWa9oBb7E0rtz9DjKEJzeFDjl5uRaxK5GnovYsZn
         3B2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lJRjCM+MHGrkfk6BQUd45RS2LvGotJKtsd5H7I/2Cv4=;
        b=eouy+geloG6DBdn8uKMdfZzyNrJ3shYED9M0lTTChK8URy1W3L2XU9c2qgc/UKpKXe
         IkAdYBIJJAMjuYTFC4Dm9CPzgtFpoEcyc/qflWYEc2mLvBn5cc99nM2kKWgWNGuoewFc
         mkjHSdbUFC40HvNW+Y7Nj7MX5V25UTFfC878RABsOxJpL9+5XrHZBCUu3hmksjjl3XSc
         pBkghoQAg3F9PFal2H5YHtsr/rOpJL873FfLTfQS/39SRFhh3AIkxxWOIyknJUa0E9gk
         1il9bRn8lasy0of09FUU0Uz/hIphvkQO4spIjZD5NdqujwuWMKzCqXBMaFzrv7yeIbZR
         b5zw==
X-Gm-Message-State: APjAAAUnH3KyKWQLfObxKkEE3jXYUhc9QXqwBAlNWKOgEEetiP3hPsOC
        UXYzYGi1uFwsgvNK8CfIah7Rk2ic
X-Google-Smtp-Source: APXvYqxTc3R4l2jC2KuQqqMchy9puDwilHSoT9NsHY7Xs5Ri37HjK5x7wnP71Xt2PgsrVYgDgZx0Ow==
X-Received: by 2002:a1c:f30d:: with SMTP id q13mr4423497wmq.60.1569012225084;
        Fri, 20 Sep 2019 13:43:45 -0700 (PDT)
Received: from [192.168.2.202] (pD9E5A855.dip0.t-ipconnect.de. [217.229.168.85])
        by smtp.gmail.com with ESMTPSA id z13sm2266965wrq.51.2019.09.20.13.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 13:43:44 -0700 (PDT)
Subject: Re: [PATCH] serdev: Add ACPI devices by ResourceSource field
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190919195624.1140941-1-luzmaximilian@gmail.com>
 <50b016a1-ed4a-b848-4658-a05731727d7e@redhat.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <ff0588a9-d395-3101-ba01-802e736e86a3@gmail.com>
Date:   Fri, 20 Sep 2019 22:43:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <50b016a1-ed4a-b848-4658-a05731727d7e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

> So as promised I've given this patch a try, unfortunately it breaks
> existing users of ACPI serdev device instantation.

I've only had a short look at it so far. As far as I can tell, there are
two options: Either the device does not match/is being skipped, or there
are errors (which are currently only reported with dev_dbg, based on the
pre-patch implementation) causing the search to terminate early. I'll
keep investigating this and report back once I've got a better
understanding of the possible sources for this.

> I haven't looked why your patch is breakig things, I have a large backlog
> so I do not have time for that.

No worries, I'll try to figure this out.

> But if you can provide me with a version of the patch with a bunch of
> debug printk-s added I'm happy to run that for you.

Thank you for this offer, I will probably come back to it once I have
more of an idea what could cause the breakage.

Regards,

Maximilian

