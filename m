Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92257DBD27
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Oct 2019 07:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389961AbfJRFld (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Oct 2019 01:41:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33436 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442014AbfJRFla (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Oct 2019 01:41:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so3158605pfl.0
        for <linux-acpi@vger.kernel.org>; Thu, 17 Oct 2019 22:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p0ZcA5/U4vLBP3fm6ZAT4nlCcb5dQ4JwVYP/+NI5L6w=;
        b=Rq4Rw84jFpBv+yeL1kstTX8oUutO2S4aOm/OKwIv0HgnEm+eEWyDVp+n+8sV/yLTlp
         EKNLZNFpF/6t0n6akdQb6609x3y19LkwO48lMQrq+mLQ1bv3DpCLuS5ohwyegSa08yKf
         CqkF4CgAc0jtuOKIUMudTnVuk8MMCG3MVyIYs/YU61Hbb3zRxI9JgxFWiUWZQVwz1yXa
         eHuGTbH/apzwV1r0LiLS5r9Rz8N51bC1LcbgWN7HuAoMf5BD+d2ktkJ6+tg7EeE22NTL
         e8MhubDpr7usb9CeDrkGO0y+6iqpx2UuYMg/Op6fwXmBI+IStEyRnouVbgCXf0NRZJlD
         rWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p0ZcA5/U4vLBP3fm6ZAT4nlCcb5dQ4JwVYP/+NI5L6w=;
        b=P7R323s8pfiV0j/vfWyz8yDNunGX77dGDThSJjFJbtx6/l6yYFtHwnAxmzQk/6MPMS
         rPDDXs7wTfHl3hjVA30SkXsOnmAYcZas2RrfjcII0Hb+qeV2yj/RJjF8TP2lkoB6ZP/8
         AQhcVgtEvBaLncZhp1mFJqNxqiM5/Vm56zFie+yVVjra5WUVjSptrTgxqPUcbO5BTpOO
         N5ZtlKRcMfvBMgdxXVOV6N7glAnY2SOgmwqOrD1ytA5tEVi6VRNXJDiuyZsSh3bd6T7g
         OYkg5Wv1wyQ7ObeC+CGayz4ZVb9Qs7n/LM30cij/soAoviP07Qbba8euIVhD85WGv8x1
         TwTQ==
X-Gm-Message-State: APjAAAUHpnvi5mHS0BQNlUkTfhkXWrionKPGrzGWTSX2KyIKqlk7aFYK
        3/8S9aO7ZfVns6YsPl2jjCuM+g==
X-Google-Smtp-Source: APXvYqxCBYnbkeb5IZKjGre+6VciDOyz3GYaUWRD7jLEy8anyNUwplve1VOtoA2UYkJzC8Y5d9VTag==
X-Received: by 2002:a17:90a:9406:: with SMTP id r6mr9337135pjo.0.1571377289149;
        Thu, 17 Oct 2019 22:41:29 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id k17sm5036033pgh.30.2019.10.17.22.41.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 22:41:28 -0700 (PDT)
Date:   Fri, 18 Oct 2019 11:11:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [RFT][PATCH 1/3] PM: QoS: Introduce frequency QoS
Message-ID: <20191018054126.n7zsqut7z3hzh7bc@vireshk-i7>
References: <2811202.iOFZ6YHztY@kreacher>
 <4551555.oysnf1Sd0E@kreacher>
 <20191017094143.fhmhgltv6ujccxlp@vireshk-i7>
 <CAJZ5v0hDhJrCWnPxbV54yWAB=DKCLz33Sq8J4kXtqH4+mJn2eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hDhJrCWnPxbV54yWAB=DKCLz33Sq8J4kXtqH4+mJn2eQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 17-10-19, 16:16, Rafael J. Wysocki wrote:
> [Also note that the current code in device PM QoS uses MIN and MAX
> here in the same way. :-)]

Stupid me, enough embarrassment for the day :(

-- 
viresh
