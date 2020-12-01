Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2392CADA8
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Dec 2020 21:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387657AbgLAUqc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Dec 2020 15:46:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28623 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725977AbgLAUqa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Dec 2020 15:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606855502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ov26aUKDmk333qW5KbP6l/xMlK1g1pdmqGPKECeqc6k=;
        b=VeWxvj41kU7rPKcED7D36A6mhnywyrMd4QIvJe2R+BBkyPFYab553T0MCPS3tc2TRYdAaZ
        rmmlcNPv0RYSv4WDmrExu9FveaJekJGyvJOo8+qJ4Yz1jBBz+dvuiupsdVEgcuMNGqXSNl
        pNdzYZMlc+TM8lPV6dZKTFWU/1mbNmk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-aKEvtFDoNXyIj6tdcydurw-1; Tue, 01 Dec 2020 15:45:01 -0500
X-MC-Unique: aKEvtFDoNXyIj6tdcydurw-1
Received: by mail-ej1-f71.google.com with SMTP id a8so1899945ejc.19
        for <linux-acpi@vger.kernel.org>; Tue, 01 Dec 2020 12:45:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ov26aUKDmk333qW5KbP6l/xMlK1g1pdmqGPKECeqc6k=;
        b=hrXbQJ5u4eCXlHhDyB5n8JW9azReJkgV0uIYaH+j9O3aAcmP4+gU469jWtqIIRZ7RQ
         viyUWgoxWcwso/yt57jLI1rtrvsSUBHcEy4gYSdLqOuDnT2NlQMziJ0C30GC8DsM/OCZ
         UatP3AYJuYB/3FFkE1fBE+V1S5M7yQlWvxa4oYuUOS1U8gk0uH0YJxvoyxO0z/osl9+Y
         eeRu5KMQreJsFYmBNHrjUVuX8HYqyTS7sBdHvZVJz1xMW67z6Cc0baZagANcXq9OndeE
         tlplWltTtfNvMNe/AH4yqJVArpCBWu9h9PUarDCAZjrWmukY0uW3OvJMiKc9xW4HFb6t
         61FQ==
X-Gm-Message-State: AOAM532h8dCp6tD43HP++WyT3MSzo3hr5Px0W2VmXvAdijxLkt2QiYL0
        7tM4geW9lHXmFuVuh3zNhiuWllA6odh5ERpF5Ij5k3FukIi8/jW+aaL9/Cysdl4Oomq05rZyuk/
        H8n8qjyFFoSoaw4oVxw4+pw==
X-Received: by 2002:a50:b264:: with SMTP id o91mr4954963edd.7.1606855497979;
        Tue, 01 Dec 2020 12:44:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQ9VBuVw+s2KqEBC/5bGsxmX53Yi6Agrk0WunjInyhPJw5ytIZ4HxkCWD0zO6F8buawvWjjQ==
X-Received: by 2002:a50:b264:: with SMTP id o91mr4954938edd.7.1606855497699;
        Tue, 01 Dec 2020 12:44:57 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id d1sm370720eje.82.2020.12.01.12.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 12:44:56 -0800 (PST)
Subject: Re: [External] Re: [PATCH v4 3/3] platform/x86: thinkpad_acpi: Add
 platform profile support
To:     Mark Pearson <markpearson@lenovo.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     mgross@linux.intel.com, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, hadess@hadess.net,
        pobrn@protonmail.com, mario.limonciello@dell.com,
        eliadevito@gmail.com, bberg@redhat.com, dvhart@infradead.org
References: <markpearson@lenovo.com>
 <20201126165143.32776-1-markpearson@lenovo.com>
 <20201126165143.32776-3-markpearson@lenovo.com>
 <e8dee4f7-3559-71a3-51d4-0b93b004715a@redhat.com>
 <a02480ac-4f37-1d22-700b-e1b3565bb57f@lenovo.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <6e011912-2db0-5151-2417-74b7edb04888@redhat.com>
Date:   Tue, 1 Dec 2020 21:44:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <a02480ac-4f37-1d22-700b-e1b3565bb57f@lenovo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 12/1/20 5:51 PM, Mark Pearson wrote:
> Hi Hans,
> 
> Sorry for the slow reply on this one - I went and did some investigation/testing first (and the US came back from Thanksgiving with a vengence of meetings....)
> 
> On 28/11/2020 09:55, Hans de Goede wrote:
>> Hi,
>>
>> On 11/26/20 5:51 PM, Mark Pearson wrote:
> <snip>
>>>
>>>    drivers/platform/x86/thinkpad_acpi.c | 306 ++++++++++++++++++++++++++-
>>>   1 file changed, 305 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
>>> index 6a4c54db38fb..8463170391f5 100644
>>> --- a/drivers/platform/x86/thinkpad_acpi.c
>>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>>> @@ -72,6 +72,7 @@
>>>   #include <linux/uaccess.h>
>>>   #include <acpi/battery.h>
>>>   #include <acpi/video.h>
>>> +#include <linux/platform_profile.h>
>>
>> Please group this together with the other linux/foo.h includes.
> Ack.
> 
> Is it OK if I tidy up the list to be alphabetical as seems generally preferred, or would you rather I didn't mess with it apart from the one small adjustment?

I would welcome a *separate* patch to sort things alphabetically, either as a preparation or as a follow-up patch.

But please don't combine that with this patch.



>>
>>>   
> <snip>
>>> +}
>>> +
>>> +static int dytc_perfmode_get(int *perfmode, int *funcmode)
>>> +{
>>> +    int output, err, cmd_err;
>>> +
>>> +    if (!dytc_profile_available)
>>> +        return -ENODEV;
>>> +
>>> +    err = dytc_command(DYTC_CMD_GET, &output);
>>> +    if (err)
>>> +        return err;
>>> +
>>> +    *funcmode = (output >> DYTC_GET_FUNCTION_BIT) & 0xF;
>>> +    if (*funcmode == DYTC_FUNCTION_CQL) {
>>> +        int dummy;
>>> +        /*
>>> +         * We can't get the mode when in CQL mode - so we disable CQL
>>> +         * mode retrieve the mode and then enable it again.
>>> +         * As disabling/enabling CQL triggers an event we set a flag to
>>> +         * ignore these events. This will be cleared by the event handler
>>> +         */
>>> +        dytc_ignore_next_event = true;
>>> +        err = dytc_command(DYTC_DISABLE_CQL, &dummy);
>>> +        if (err)
>>> +            return err;
>>> +
>>> +        cmd_err = dytc_command(DYTC_CMD_GET, &output);
>>> +        /* Check return condition after we've restored CQL state */
>>> +
>>> +        /* Again ignore this event */
>>> +        dytc_ignore_next_event = true;
>>
>> Are we sure the event-handler will have run before we do this second
>> setting of the ignore_next_event bool? Maybe make it an atomic integer
>> and increment / decrement the variable ?
>>
>> E.g.:
>>
>> Declaration:
>>
>> static atomic_t dytc_ignore_next_event = ATOMIC_INIT();
>>
>> Ignore next event:
>>         atomic_inc(&dytc_ignore_next_event);
>>        
>> Check if event should be ignored:
>>
>>         if (!atomic_add_unless(&dytc_ignore_next_event, -1, 0))
>>             dytc_profile_refresh();
>>
>> Note atomic_add_unless may needs some explanation, it adds -1 unless
>> the atomic_t already contains 0. And it returns true if the addition
>> was done. so if it returns true then dytc_ignore_next_event was not 0
>> (it might be zero afterwards).
>>
>> IOW if atomic_add_unless returns true then dytc_ignore_next_event was true,
>> so then we should NOT continue with the refresh.
>>
> In my testing the event handler always ran first, but the atomic approach is much nicer - thank you for the suggestion.
> I've played a bit with this and tried a few things over the last few days and it has been working nicely
> One thing I noticed is I think I need to add a mutex to protect so that a FN key press won't interfere with a user space access and vice-versa.

Ok, sounds good (adding a mutex if necessary is fine).

> 
>>
>>
>>
>>> +        err = dytc_command(DYTC_ENABLE_CQL, &dummy);
>>> +        if (err)
>>> +            return err;
>>> +        if (cmd_err)
>>> +            return cmd_err;
>>> +    }
>>> +    *perfmode = (output >> DYTC_GET_MODE_BIT) & 0xF;
>>> +    return 0;
>>> +}
>>> +
>>> +/*
>>> + * dytc_profile_get: Function to register with platform_profile
>>> + * handler. Returns current platform profile.
>>> + */
>>> +int dytc_profile_get(enum platform_profile_option *profile)
>>> +{
>>> +    int funcmode, perfmode;
>>> +    int err;
>>> +
>>> +    err = dytc_perfmode_get(&perfmode, &funcmode);
>>> +    if (err)
>>> +        return err;
>>
>> Can't we used a cached value here ? I presume we get an
>> event when this is changed by the hotkey ? Esp. with the
>> whole enable/disable CQL dance getting the value seems a
>> bit expensive, so using a cached value might be better?
> 
> Agreed - I'll implement.
>>
>>> +
>>> +    /* Convert Lenovo DYTC profile to platform_profile */
>>> +    err = convert_dytc_to_profile(perfmode, profile);
>>> +    if (err)
>>> +        return err;
>>> +
>>> +    dytc_current_profile = *profile;
>>> +    return 0;
>>> +}
>>> +
>>> +/*
>>> + * dytc_profile_set: Function to register with platform_profile
>>> + * handler. Sets current platform profile.
>>> + */
>>> +int dytc_profile_set(enum platform_profile_option profile)
>>> +{
>>> +    int cur_perfmode, cur_funcmode;
>>> +    int output;
>>> +    int err;
>>> +
>>> +    if (!dytc_profile_available)
>>> +        return -ENODEV;
>>> +
>>> +    if (profile == platform_profile_balance) {
>>> +        /* To get back to balance mode we just issue a reset command */
>>> +        err = dytc_command(DYTC_CMD_RESET, &output);
>>> +        if (err)
>>> +            return err;
>>> +    } else {
>>> +        int perfmode;
>>> +        int cmd_err;
>>> +
>>> +        err = convert_profile_to_dytc(profile, &perfmode);
>>> +        if (err)
>>> +            return err;
>>> +
>>> +        /* Determine if we are in CQL mode. This alters the commands we do */
>>> +        err = dytc_perfmode_get(&cur_perfmode, &cur_funcmode);
>>> +        if (err)
>>> +            return err;
>>> +
>>> +        if (cur_funcmode == DYTC_FUNCTION_CQL) {
>>> +            /* To set the mode we need to disable CQL first*/
>>> +            dytc_ignore_next_event = true; /* Ignore event */
>>> +            err = dytc_command(DYTC_DISABLE_CQL, &output);
>>> +            if (err)
>>> +                return err;
>>> +        }
>>
>> This seems somewhat duplicated from the get() code-path. Also you already doing
>> a DYTC_DISABLE_CQL and DYTC_ENABLE_CQL in dytc_perfmode_get, which is not necessary
>> to just get the funcmode which is all you need here AFAICT.
>>
>> IOW it seems that when CQL is active you are now doing:
>>
>> 1. dytc_perfmode_get() calls DYTC_CMD_GET
>> 2. dytc_perfmode_get() calls DYTC_DISABLE_CQL
>> 3. dytc_perfmode_get() calls DYTC_CMD_GET again, result is ignored (not used by dytc_profile_set)
>> 4. dytc_perfmode_get() calls DYTC_ENABLE_CQL
>> 5. dytc_profile_set() calls DYTC_DISABLE_CQL
>> 6. dytc_profile_set() calls DYTC_SET_COMMAND
>> 7. dytc_profile_set() calls DYTC_ENABLE_CQL
>>
>> And you can really skip step 2-4 here.
>>
>> I think it would be good to add a bunch of helpers:
>>
>> 1. dytc_get_modes() -> DYTC_CMD_GET wrapper gets both modes, sets perfmode
>> to -1 when funcmode is CQL
>> 2. dytc_disable_cql_if_necessary() which takes funcmode as argument and is
>> a no-op when funcmode != CQL
>> 3. dytc_re_enable_cql_if_necessary() idem.
>>
>> And then the flow in dytc_perfmode_get could look something like this
>> (pseudo code minus error handling):
>>
>>     dytc_get_modes(&funcmode, &perfmode)
>>     if (funcmode != CQL) /* or alternatively check for perfmode != -1 */
>>         return success;
>>
>>     dytc_disable_cql_if_necessary(funcmode);
>>     dytc_get_modes(NULL, &perfmode);
>>     dytc_disable_cql_if_necessary(funcmode);
>>
>> And in the non-balanced path of dytc_profile_set:
>>
>>     dytc_get_modes(&funcmode, NULL)
>>
>>     dytc_disable_cql_if_necessary(funcmode);
>>     dytc_set_mode(...);
>>     dytc_disable_cql_if_necessary(funcmode);
>>
>> Note the NULL could be a dummy, but I find NULL a bit cleaner
>> (at the cost of having to check for it in dytc_get_modes).
>>
>> This is is just from a quick peek, when you implement this
>> it might turn out to be less then ideal, IOW this is just
>> a suggestion, feel free to deviate.
> 
> Agreed - and thank you for the suggestions. I did prototype a similar method and it has worked out nicely. I've got a bit more cleanup but the code is better than it was.
>>
>> ###
>>
>> Since this will require a bit of work, timing wise (wrt the 5.11 merge-window)
>> it might be best to just keep this patch as is for v5, and only change
>> patch 1 and 2 of the set, so that those will hopefully be ready for
>> merging in time for the 5.11 window. I plan to pick this one up
>> once 5.11-rc1 is out (and has the necessary ACPI bits) so we have some
>> more time to get this one in shape.
>>
>> For patch 1/2 the most important thing is to have a consumer of the
>> new internal APIs (almost) ready and this code fulfills that in
>> its current form.
>
> OK - I think that makes sense. Just curious though - will you then just accept the platform_profile pieces (1 & 2)? Would it make it easier if I just push the updated first two patches and drop thinkpad_acpi.c for now (it will follow shortly, but is going to be a couple more days) or would you rather have everything and just pick the bits you want?

Patches 1 & 2 should be merged by Rafael, who maintains drivers/acpi,
normally I would then ask Rafael for an immutable branch with those bits
and merge that into platform-drivers-x86.git/for-next and then merge the
3th patch there.

But given the timing it will be easier to just wait for 5.11-rc1, assuming
Rafael is still willing to take 1 and 2 as 5.11 material. The time window
for that is closing.

Rafael, would you be willing to take patches 1 and 2 of this series as
5.11 material assuming a new version addressing my review remarks get
posted soon and I then give my Reviewed-by ?

> I've got the v5 ready (I think) for the platform profile and am still working on thinkpad_acpi.c with the improvements from above. I think I'll be a couple more days there.

It would be best if you can send out v5 soon, even if the thinkpad_acpi
patch is not in perfect shape yet, it will still illustrate how the new
internal APIs from patch 2 will be used, which is very useful for
reviewing patch 2.

Regards,

Hans

