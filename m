Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1F9F18B1AF
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Mar 2020 11:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgCSKqP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Mar 2020 06:46:15 -0400
Received: from a3.inai.de ([88.198.85.195]:57644 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgCSKqP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 19 Mar 2020 06:46:15 -0400
Received: by a3.inai.de (Postfix, from userid 25121)
        id 7CF0758741010; Thu, 19 Mar 2020 11:46:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 7942F61041455;
        Thu, 19 Mar 2020 11:46:13 +0100 (CET)
Date:   Thu, 19 Mar 2020 11:46:13 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc:     linux-acpi@vger.kernel.org
Subject: Re: [PATCH] x86: ignore unspecified bit positions in the ACPI global
 lock field
In-Reply-To: <2030043.rEjxodZhqh@kreacher>
Message-ID: <nycvar.YFH.7.76.2003191136480.30451@n3.vanv.qr>
References: <20200305122425.32223-1-jengelh@inai.de> <2030043.rEjxodZhqh@kreacher>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On Saturday 2020-03-14 10:46, Rafael J. Wysocki wrote:
>On Thursday, March 5, 2020 1:24:25 PM CET Jan Engelhardt wrote:
>> The value in "new" is constructed from "old" such that all bits defined
>> as reserved by the ACPI spec[1] are left untouched. But if those bits
>> do not happen to be all zero, "new < 3" will not evaluate to true.
>> 
>> The firmware of the laptop(s) Medion MD63490 / Akoya P15648 comes with
>> garbage inside the "FACS" ACPI table. The starting value is
>> old=0x4944454d, therefore new=0x4944454e, which is >= 3. Mask off
>> the reserved bits.
>> 
>> -	return (new < 3) ? -1 : 0;
>> +	return ((new & 0x3) < 3) ? -1 : 0;
>
>Applied as 5.7 material, thanks!

Would it make sense to funnel this into the upcoming 5.6?
