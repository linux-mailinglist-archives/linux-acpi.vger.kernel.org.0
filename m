Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1292356F1B
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 16:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345264AbhDGOqa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Apr 2021 10:46:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30187 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244998AbhDGOq2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Apr 2021 10:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617806778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mg+fAs8HiCSf9usDBnxdCzvZm/dqxv2o27VRQ8dpGpE=;
        b=jPKzwiE/9AoSGrNd6RS6OlZy9VUmoO3MiNoeuBRWjLsQ+vNITic18iddsbp42livXzPLHo
        p1Pc7bJNBdgyFQeDatDNH8efOGixIhiZmVVV2L1PS9QCoPCjGo2ANNIB6CfCkUarzS6jxd
        wbmegmsLEDUPPfXB0/4LjcupsH2YUuM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-gDW4DfkzNLapO_dRws_m8Q-1; Wed, 07 Apr 2021 10:46:16 -0400
X-MC-Unique: gDW4DfkzNLapO_dRws_m8Q-1
Received: by mail-ej1-f69.google.com with SMTP id zn19so3093228ejb.14
        for <linux-acpi@vger.kernel.org>; Wed, 07 Apr 2021 07:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mg+fAs8HiCSf9usDBnxdCzvZm/dqxv2o27VRQ8dpGpE=;
        b=bIdsby+DzBoDloK46W6shhOF9iWeuL9Gz0yqVDIQnT1WB5dzMwnRaxZEEPM7EwQI1D
         SPLL0i71+lKchvb0fiLzrVRWty7y2NT5PvFcK5lEPpaiIX5u/j6iXrAvtZn6mImXVy+D
         C5uTvUT7ONNVA29nwJczhp7Gsm1MbOYszw1zkDjPReZpVR0NdDWhZpR9lK8TOCTPDF+c
         jL5tFaNfGyTM36e3xN6JXMGvX5BpVre9P8ViuQ2hgv8du/o/cW3E9zB39JYx1UMW+XQD
         feaPIQSb7h5STXzosxdsVtR07Q7dOjVKUWS4xFbKKogFOW9bFPSI9Cw+uqxRWbotAMxE
         9ZHw==
X-Gm-Message-State: AOAM530W9bSXF5zGiU02rAnu61p2y8bcu8vermbbQXafG9+BsJC4kS2T
        yCiCb37xPr4pTA8x3sHbDewuk7t3q+hsDYtet1sH6Wm2xi9OdhCpmpm9khQ6DzM5ON72O/y9KRW
        kz+saWHw9OnLBCJjLYKRJow==
X-Received: by 2002:a17:907:628a:: with SMTP id nd10mr4143793ejc.326.1617806775283;
        Wed, 07 Apr 2021 07:46:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHhBqm26Mm7YFhs88gM9OOeiQCRSbPAmpao8DVnIAjK0sCenydd7fdhGuJ2WWq8h5whHoFsw==
X-Received: by 2002:a17:907:628a:: with SMTP id nd10mr4143783ejc.326.1617806775169;
        Wed, 07 Apr 2021 07:46:15 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id x17sm12698028ejd.68.2021.04.07.07.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 07:46:14 -0700 (PDT)
Subject: Re: [PATCH v1 0/5] ACPI: scan: acpi_bus_check_add() simplifications
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <2192169.ElGaqSPkdT@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c50d3bc1-e40c-a66d-35fe-823a1398989d@redhat.com>
Date:   Wed, 7 Apr 2021 16:46:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <2192169.ElGaqSPkdT@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 4/7/21 4:27 PM, Rafael J. Wysocki wrote:
> Hi,
> 
> This series simplifies acpi_bus_check_add() and related code.
> 
> It mostly is not expected to alter functionality, except for patch [4/5] that
> unifies the handling of device and processor objects.
> 
> Please refer to the patch changelogs for details.

Thanks, the entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

