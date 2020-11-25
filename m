Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB172C48CE
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Nov 2020 21:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgKYT7U (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Nov 2020 14:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728787AbgKYT7U (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2020 14:59:20 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B73C0613D4
        for <linux-acpi@vger.kernel.org>; Wed, 25 Nov 2020 11:59:10 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id k4so3881812edl.0
        for <linux-acpi@vger.kernel.org>; Wed, 25 Nov 2020 11:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=jbfTdCGww66Z0VbjBD6uZEAVvydGJ8vXqvNyKFXLJcE=;
        b=vNXvGB+RbB5PSVcqAcqpdltJ3kzxx+IxI1eOX6IhRFu+VDJEgNb9Ytzxcal52ydfsI
         Kt7iJ2Zmto79+9DMHGiUOy5hRhy6+M+87YPaNWTl+Zgu8Y9gOi0gplpCR5zZypapBCYS
         B7TfLXJWha+1+SmSzmg5MCFXX6CFDj8JsuzhzxJgQb2yxW548eP3bABQfQVjTuUEyYDd
         1IoTXQ3epZl8ruwxWhvdf3mIq6ICibDytQ8aabGm2wDkT+hA3hR6dsmCHpvVCAvJBHKH
         YozDAlsX1E4W6/SDFaJPG99//bVEyDYtSOQXSvHS13gLjMjKji7LQWV02JpqmniS2OHv
         kpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=jbfTdCGww66Z0VbjBD6uZEAVvydGJ8vXqvNyKFXLJcE=;
        b=pmJxd/w3bilf0nS1E57TwJ4dB79BAnqd+qSUlRVyey8DE9J5/ouvYBcKW97+d+jKyq
         cl2zwQTZ+Hgan9Nwg35/Yd9Aupdbc7DYx5UGR+qz7v38qBwVYdfUUJ8J4ahoSsHyrEJg
         Jbs2GESPIEDBkRec6By5PkYjROJkWhjVWrqwqc4h1BE9gjaUlWYjFUjqSFZjsKu+J0yS
         vz7V+A8IFlxPwnXhMxgY+axBsFS4GGid+ZedtDr61cu/X7329X7g2g4pdSpyy5CTwBIs
         miPx4njnNyC7Ek6CKWyRPcUYjnt1myHplijh2aQUsNnagyawsnR102w/CJJbRl5rMb6X
         VreA==
X-Gm-Message-State: AOAM5314JlTS+6yLmNF0ItIq+D9eL+mIeznTZiK9n5qRT0w5CuT6WwyV
        qloPAt8mGcoeJK0frfXghw==
X-Google-Smtp-Source: ABdhPJzbLQGxXq71gv9BntKkAGE7n02BOE015fjjHnDG3gQ5agsx9zza4T4u1Lc4FyqPdo/uCloPWQ==
X-Received: by 2002:a50:f604:: with SMTP id c4mr5046212edn.117.1606334349181;
        Wed, 25 Nov 2020 11:59:09 -0800 (PST)
Received: from localhost.localdomain ([46.53.253.100])
        by smtp.gmail.com with ESMTPSA id gj23sm1893896ejb.27.2020.11.25.11.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 11:59:08 -0800 (PST)
Date:   Wed, 25 Nov 2020 22:59:06 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org
Subject: evaluation order bug in acpi_pic_sci_set_trigger() ?
Message-ID: <20201125195906.GA3809000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

acpi_pic_sci_set_trigger() contains the following code:

	/* Real old ELCR mask */
	old = inb(0x4d0) | (inb(0x4d1) << 8);

Operand evalution order is not guaranteed for binary or.
I wonder if this is a bug?

	Alexey
