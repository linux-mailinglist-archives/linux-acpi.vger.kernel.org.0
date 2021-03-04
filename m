Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAA032D680
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 16:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbhCDPYE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Mar 2021 10:24:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25150 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232276AbhCDPXy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Mar 2021 10:23:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614871348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=flHvEj8UDJKQ3YikBZFm0lGJDaKdu4G9T3daMyGyBjA=;
        b=HHsBLt2TcYyv/xAL9roqNhAnuYIB0TInpOEOF+MdemaJMOMuVZLSkYaHI4IRNM85FNwJec
        jvc1j6QBE2M/dqWZnMXWMUgp3laqadqg8zDPebU1P5YgqPTJ71T7oN3llOSvzRrppeq5aC
        SWsipfDi8xacDqJ5dSIXepUwx1wU2Xs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-vE6t1vjaP4OuoJUTLzlQdw-1; Thu, 04 Mar 2021 10:22:26 -0500
X-MC-Unique: vE6t1vjaP4OuoJUTLzlQdw-1
Received: by mail-ej1-f71.google.com with SMTP id gb19so12303876ejc.11
        for <linux-acpi@vger.kernel.org>; Thu, 04 Mar 2021 07:22:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=flHvEj8UDJKQ3YikBZFm0lGJDaKdu4G9T3daMyGyBjA=;
        b=gQRV4v0J9LDJ7ZQK8i/6N1YEjyISt9UcYELAt+8iBacYOzze3YaB7tz/MQwmMtrlA1
         s63S3Q7lnzQRRjmS2APiGpAegYb48UpHCdZ3gjpmheUzwDksBn8G2m2puAmxCXV4aL1F
         RENplSpYnygM7l568paS3N0LIX1I6vnoLuTPto59QSIiXUw0Z5B/Mt9qiOACh+K0EvNd
         R2g5hTMLdDt/06OmplW3nR8HgQF0/j1VKS7hcT6ZWMYAd5u5NlZj9NY/2SKLEnexnv2x
         VGS/rAEmCFaJUP/hpzPv13FbIbRGNSfhywXvV/JK1rcZPORJgO6F/pW7lZC+xvaZGpVg
         9Y6A==
X-Gm-Message-State: AOAM531h44MTAi3Dya+3f9kQJmtVglDGg2S05J6zEgRqVDaNlqikTUfl
        I0vwNXjpshGFoa0YvICTzggAbkOWd6wi0MhsGaA/GsLEpbKb94HBaFcyEPMHtK8GwyrnWnTZKLy
        /SL50AbJEJIhTOXvd9g//0uprO8oaYaH8iAclcA5bt1SFtqzZk84OrvXOc5wmDz6+XzYkSecuiA
        ==
X-Received: by 2002:a05:6402:402:: with SMTP id q2mr4962997edv.116.1614871345051;
        Thu, 04 Mar 2021 07:22:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+oTro4A0KstYDWVv397tK7fqCTLkSo3LrcO+Daz6slkR5RYC2pUzagFANCAr8Eo4c57dnvQ==
X-Received: by 2002:a05:6402:402:: with SMTP id q2mr4962981edv.116.1614871344909;
        Thu, 04 Mar 2021 07:22:24 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id d3sm20257737edp.43.2021.03.04.07.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 07:22:22 -0800 (PST)
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi <linux-acpi@vger.kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Meaning / use of acpi_driver.class and acpi_device_class() fields ?
Message-ID: <15858590-7be3-67d0-ccca-a55f20a7873a@redhat.com>
Date:   Thu, 4 Mar 2021 16:22:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

While reviewing a new acpi-driver:
https://patchwork.kernel.org/project/platform-driver-x86/patch/CAFysUkSztjJpSjKA92a=3j3Nj7vfQy5TCsiJtNmfjegxLBvFSA@mail.gmail.com/

I was wondering what the meaning / use of the acpi_driver.class and
acpi_device_class() fields is and if these should be set to anything
specific ?

I did a quick grep and most drivers seem to set this to a string describing
the driver / to the driver-name and they seem to set the 2 fields to the
exact same value. But some drivers also use different values for
acpi_driver.class and acpi_device_class() ?

Regards,

Hans

