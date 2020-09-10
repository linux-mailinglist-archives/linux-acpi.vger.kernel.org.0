Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3927B265296
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Sep 2020 23:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgIJVVA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Sep 2020 17:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgIJVUu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Sep 2020 17:20:50 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AB3C061573;
        Thu, 10 Sep 2020 14:20:50 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id a12so7797990eds.13;
        Thu, 10 Sep 2020 14:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zPVHbCJybvi4hZBOOfe3/sEPx6neciP5fKuOCH2ikQ4=;
        b=Uf14ka4hEk5zwFTsEoRRZliwotxjy/CFMjKdL4NnyayRTwKcWhKgy7ulCZYABm0rHa
         epcWCvOtu5ZM+yHTxEZAtAid/5aVvEhKbu9EN/dgGIOCeMu/5yjF1txmTjT40Xku2D/8
         WlDC3sn0FcY9Ql5u37cgX3JmmXAwf1DQsC1+ZTZBKgHzQC+4jjNQ8pYRq06O11m8Or8b
         pFogetF7TRJQfBcpkTpGjGrtnuxMEn91G7iVPfUpDB6dVz9zmXwVGlftiZpifyVNFGom
         I7QDCl+hIVOjVBXtKVloKcxDJgNHO2Bhh4akW+lJ9yGHU/7fjlcepQKcmRB/jNjPzfw0
         VyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zPVHbCJybvi4hZBOOfe3/sEPx6neciP5fKuOCH2ikQ4=;
        b=QUHKxgQ6O6TYcFKGkUjofqUtM1yHbs5uq0evnHi2XVIi6BUGDq9WkBwV215i/c3uLK
         M6UInZt3wSr12qlOhLnlL6So3W5inUujP3xB4Sx8+8bjXdfGtaoTlzrJL2j6pu3eOv71
         93jx6l8YWFf3yI8cvkHqlGZgXavEULpIkK/XGQRDcS7mkdKT8nUBmFqRuLRQJ8KiEuiR
         J0wLAp0ICXcB0YF80llq69Qo/rV7YQaOhIiwSd10J+aM4OFqkJ+5se+VRCGgTToviORo
         kxLUDKQF0RAngL8/tjTkmhHPXNsj63EmR7KXK35eO/u+kpGBbyzPWRAS0UhZFdjGaSg2
         OfxA==
X-Gm-Message-State: AOAM533D+QsHrNSe4cmbuBv6baFnzHaTiCYgTq4y1bvNCSGMzxLUUh9o
        pYNKgXoH7ku3MAuMU+LOugbL5TDh6SA=
X-Google-Smtp-Source: ABdhPJzLFpP3bAeWPQ4tPlEgmqH6BdhhBz2cc8f7T8+ZynM8xV2O10o3qgfbmw9EgxtgLefS0InROw==
X-Received: by 2002:a50:a694:: with SMTP id e20mr11397676edc.114.1599772847401;
        Thu, 10 Sep 2020 14:20:47 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a079.dip0.t-ipconnect.de. [217.229.160.121])
        by smtp.gmail.com with ESMTPSA id y14sm65322eje.10.2020.09.10.14.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 14:20:46 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: Add Driver to set up lid GPEs on MS Surface
 device
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200908171934.1661509-1-luzmaximilian@gmail.com>
 <CAHp75VevrwKaba_FsZj-nPqJGR9fkmFPzvdCew0wCqF_L6QLbA@mail.gmail.com>
 <d1d3b1bb-1d7b-ae8d-fbe4-23f995df47fb@gmail.com>
Message-ID: <536e5617-c143-0e8a-d629-90c058a71c5f@gmail.com>
Date:   Thu, 10 Sep 2020 23:20:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <d1d3b1bb-1d7b-ae8d-fbe4-23f995df47fb@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


I've just sent v2.

Thank you for your comments,
Max
